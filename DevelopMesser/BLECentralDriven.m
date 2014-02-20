//
//  BleDriven.m
//  iColorLed
//
//  Created by 金磊 on 13-11-17.
//  Copyright (c) 2013年 lordking. All rights reserved.
//

#import "BLECentralDriven.h"
#import "DMDebug.h"

static eventConnectBlock privateConnectBlock;
static eventActionBlock privateActionBlock;

@interface BLECentralDriven (Private)

- (BOOL)supportLEHardware;

@end

@implementation BLECentralDriven

@synthesize manager, dicoveredPeripherals, _characteristicUUID, _serviceUUID, _data, _actionType;

/*!
 *  创建单例，保证只存在一个蓝牙对象
 *
 *  @return 实例化后的单例对象
 */
+ (BLECentralDriven *)shared
{
    DMPRINTMETHODNAME();
    
    static BLECentralDriven *class;
    static dispatch_once_t onceToken;
    
    //单例模式的实例化。实例化默认调用init
    dispatch_once(&onceToken, ^{
        class = [BLECentralDriven new];
    });
    
    return class;
}

/*!
 *  中心设备的实例化方法
 *
 *  @return 返回实例化后的中心设备对象
 */
- (id)init
{
    DMPRINTMETHODNAME();
    
    self = [super init];
    if (self) {
        self.dicoveredPeripherals = [NSMutableArray new];   //初始化已经被发现外围设备
        
        //创建中心设备模式的蓝牙对象,调度队列。queue设置为空，使用主队列
        manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    
    return self;
}


/*!
 *  指定服务UUID，扫描外围设备。servicesCBUUID设置后，驱动只扫描包含提供指定服务UUID的蓝牙设备；如果设置的值为nil,那么就扫描全部蓝牙设备。
 *
 *  @param servicesCBUUID 0到多个服务UUID组成的数组。
 */
- (void)startScanWithServices:(NSArray *)servicesCBUUID
{
    DMPRINTMETHODNAME();
    
    /* options参数说明
     CBCentralManagerScanOptionAllowDuplicatesKey
     指定一个布尔值，扫描是否运行时过滤重复。
     这个值是NSNumber对象。如果是YES，过滤功能被禁用，发现事件每次产生时中心设备收到一个来自外围设备的广播包。禁用这个过滤将对电池寿命产生不利的影响,请在必要时使用它。如果是YES，多次被发现的相同外围设备被合并成一个单元的发现事件。没有特别指定，缺省值为NO。
     可在IOS5或更高版本使用。
     
     CBCentralManagerScanOptionSolicitedServiceUUIDsKey
     指定一个（NSArray）数组，确定你一组要扫描的服务UUID。
     
     设置这个选项，将使得中心设备还扫描外围设备中指定的服务。
     */
    
    NSDictionary *options = @{ CBCentralManagerScanOptionAllowDuplicatesKey: @YES };
    
    NSLog(@"services: %@",servicesCBUUID);
    
    //扫描外围设备的服务
    //调用此方法，将激活centralManager:didDiscoverPeripheral:advertisementData:RSSI:
    [manager scanForPeripheralsWithServices:servicesCBUUID options:options];
    
    //检查已经连接的外围设备
    NSArray *retrieveConnectedPeripherals = [manager retrieveConnectedPeripheralsWithServices:servicesCBUUID];
    
    for (CBPeripheral *peripheral in retrieveConnectedPeripherals) {
        DMPRINT(@"retrieve peripheral: %@",peripheral);
        
        if(![self.dicoveredPeripherals containsObject:peripheral])
            [self.dicoveredPeripherals addObject:peripheral];
    }
    
    if ([retrieveConnectedPeripherals count] > 0) {
        
        if ([self.delegate respondsToSelector:@selector(getDiscoveredPeripherals:)])
            [self.delegate getDiscoveredPeripherals:dicoveredPeripherals];
    }
}

/*!
 *  关闭扫描
 */
- (void)stopScan
{
    DMPRINTMETHODNAME();
    
    [manager stopScan];
}

- (void)connectResponse:(eventConnectBlock)block;
{
    privateConnectBlock = [block copy];
}

- (void)actionResponse:(eventActionBlock)block
{
    privateActionBlock = [block copy];
}

/*!
 *  连接一个外围设备。可以调用(void)connectResponse:block，回调取得连接状态。
 *
 *  @param uuid 外围设备的UUID
 *  @param block 返回结果的回调程序块
 */
- (void)connectPeripheralWithUUID:(NSUUID*)uuid
{
    DMPRINTMETHODNAME();
    
    CBPeripheral *currentPeripheral = nil;

    for (CBPeripheral *peripheral in dicoveredPeripherals) {
        if ([peripheral.identifier isEqual:uuid]) {
            currentPeripheral = peripheral;
            break;
        }
    }
    
    if (currentPeripheral == nil) {
        
        NSString *errorMsg = [NSString stringWithFormat:@"设备不存在:%@",uuid];
        DMPRINT("%@",errorMsg);
        
        if (privateConnectBlock) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMsg                                                                      forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"cn.net.i-life" code:-1 userInfo:userInfo];
            privateConnectBlock(nil, BLUETOOTH_STATUS_ERROR_CONNECTED, error);
        }
        
        return;
    }
    
    //连接当前的外围设备。
    //调用此方法，将激活centralManager:didFailToConnectPeripheral:error:和centralManager:didConnectPeripheral:
    /* options参数说明:
     CBConnectPeripheralOptionNotifyOnConnectionKey:
     这是一个NSNumber(Boolean)，表示系统会为获得的外设显示一个提示，当成功连接后这个应用被挂起。
     这对于没有运行在中心设备后台模式并不显示他们自己的提示时是有用的。如果有更多的外设连接后都会发送通知，如果附近的外设运行在前台则会收到这个提示。
     
     CBConnectPeripheralOptionNotifyOnDisconnectionKey:
     这是一个NSNumber(Boolean), 表示系统会为获得的外设显示一个关闭提示，如果这个时候关闭了连接，这个应用会挂起。
     
     CBConnectPeripheralOptionNotifyOnNotificationKey:
     这是一个NSNumber(Boolean)，表示系统会为获得的外设收到通知后显示一个提示，这个时候应用是被挂起的。
     */
    [manager connectPeripheral:currentPeripheral options:nil];
}

- (void)disconnectPeripheralWithUUID:(NSUUID*)uuid
{
    DMPRINTMETHODNAME();
    
    CBPeripheral *currentPeripheral = nil;
    
    for (CBPeripheral *peripheral in dicoveredPeripherals) {
        if ([peripheral.identifier isEqual:uuid]) {
            currentPeripheral = peripheral;
            break;
        }
    }
    
    if (currentPeripheral) {
       [manager cancelPeripheralConnection:currentPeripheral];
    }
}
/*!
 *  写入数据到外围设备。使用此方法前，无需再次调用(void)connectPeripheralWithUUID:uuid连接蓝牙设备。
 *  可以调用(void)connectResponse:block，回调取得连接状态。
 *
 *  @param data               写入的数据
 *  @param characteristicUUID 服务特性
 */
- (void)writeData:(NSData*)data forCharacteristic:(CBUUID*)characteristicUUID service: (CBUUID*)serviceUUID peripheral: (NSUUID*)peripheralUUID
{
    DMPRINTMETHODNAME();
    
    _serviceUUID = serviceUUID;
    _characteristicUUID = characteristicUUID;
    _data = data;
    _actionType = BLUETOOTH_ACTION_WRITE;
    
    [self connectPeripheralWithUUID:peripheralUUID];
    
}


#pragma mark - private method


/*!
 *  检查是否支持BLE。
 *
 *  @return 是否支持。TRUE，表示支撑。
 *
 */
- (BOOL)supportLEHardware
{
    DMPRINTMETHODNAME();
    
    NSString * state = nil;
    
    switch (manager.state)
    {
        case CBCentralManagerStateUnsupported:
            state = @"当前硬件或平台不支持BLE";
            break;
        case CBCentralManagerStateUnauthorized:
            state = @"当前应用不被允许使用BLE";
            break;
        case CBCentralManagerStatePoweredOff:
            state = @"蓝牙功能已被关闭";
            break;
        case CBCentralManagerStatePoweredOn:
            return TRUE;
        case CBCentralManagerStateUnknown:
        default:
            return false;
    }
    
    DMPRINT(@"蓝牙设备状态: %@", state);
    
    return false;
}

#pragma mark -
#pragma mark CBCentralManagerDelegate methods  实现中心设备的代理接口
/*
 * 中心设备负责扫描外围的蓝牙设备，找寻自己所需要的服务。如果发现，就发起与外围设备连接请求，发送数据。
 */


/*!
 *  当中心设备更新状态时激活此方法
 *
 *  @param central 中心设备
 *
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    DMPRINTMETHODNAME();
    
    if (![self supportLEHardware]) //激活中心设备时检查中心设备是否支持BLE
    {
        @throw ([NSError errorWithDomain:@"BLE不被支持！"
                                    code:999
                                userInfo:nil]);
    }
}

/*!
 *  当中心设备发现一个外围设备，激活此调用。
 *
 *  @param central           中心设备
 *  @param peripheral        被发现的外围设备
 *  @param advertisementData 外围设备的广播数据
 *  @param RSSI              当前接收到的信号强度指示（RSSI），以分贝为单位。
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    DMPRINTMETHODNAME();
    
    //打印被发现的外围设备数据
    DMPRINT(@"发现一个外围设备。 设备属性: %@ rssi: %@, UUID: %@ advertisementData: %@ ", peripheral, RSSI, peripheral.identifier, advertisementData);
    
    //加入到被发现的设备列表中
    if(![self.dicoveredPeripherals containsObject:peripheral])
        [self.dicoveredPeripherals addObject:peripheral];
    
    if ([self.delegate respondsToSelector:@selector(getDiscoveredPeripherals:)])
        [self.delegate getDiscoveredPeripherals:dicoveredPeripherals];
}

/*!
 *  当中心设备连接成功一个外围设备，激活此调用
 *
 *  @param central    中心设备
 *  @param peripheral 外围设备
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    DMPRINTMETHODNAME();
    
    DMPRINT(@"已经连接到外围设备: %@", peripheral);
    
    //回调程序块，返回当前外围设备及其连接状态
    if (privateConnectBlock) {
        privateConnectBlock(peripheral, BLUETOOTH_STATUS_CONNECTED, nil);
    }
    
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    DMPRINTMETHODNAME();

    if (privateConnectBlock) {
        privateConnectBlock(peripheral, BLUETOOTH_STATUS_DISCONNECTED, error);
    }
    
    [peripheral setDelegate:nil];
    peripheral = nil;
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    DMPRINTMETHODNAME();
    
    if (privateConnectBlock) {
        privateConnectBlock(peripheral, BLUETOOTH_STATUS_FAIL_TO_CONNECT, error);
    }
    
    [peripheral setDelegate:nil];
    peripheral = nil;
}

#pragma mark -
#pragma mark CBPeripheralDelegate methods 实现外围设备的代理接口
/*
 * 外围设备，负责对外广播，告诉外面自己有哪些服务，并提供蓝牙服务。
 */

/*!
 *  当外围设备被探索其服务清单时，激活此调用。
 *
 *  @param peripheral 外围设备
 *  @param error      错误描述
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    DMPRINTMETHODNAME();
    
    //如果存在错误，返回错误原因
    if (error)
    {
        DMPRINT(@"外围设备 %@ 错误: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(getDiscoveredServices:withPeripheral:)])
        [self.delegate getDiscoveredServices:peripheral.services withPeripheral:peripheral];
    
    CBService *currentService = nil;
    for (CBService *service in peripheral.services) {
        if ([service.UUID isEqual:_serviceUUID]) {
            currentService = service;
            break;
        }
    }
    if (currentService == nil) {
        DMPRINT(@"不存在服务:%@", _serviceUUID);
        return;
    }
    DMPRINT(@"找到外围设备的服务:%@", _serviceUUID);
    
    [peripheral discoverCharacteristics:nil forService:currentService];
}

/*!
 *  当一个服务下的服务特性被发现时，激活此调用
 *
 *  @param peripheral 外围设备
 *  @param service    服务
 *  @param error      错误描述
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    DMPRINTMETHODNAME();
    
    //如果存在错误，返回错误原因
    if (error)
    {
        DMPRINT(@"服务 %@ 错误: %@", service.UUID, [error localizedDescription]);
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(getDiscoveredCharacteristics:withService:Peripheral:)])
        [self.delegate getDiscoveredCharacteristics:service.characteristics withService:service Peripheral:peripheral];
    
    CBCharacteristic *currentCharacteristic = nil;
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID isEqual:_characteristicUUID]) {
            currentCharacteristic = characteristic;
            break;
        }
    }
    if (currentCharacteristic == nil) {
        DMPRINT(@"不存在服务特性:%@", _characteristicUUID);
        return;
    }
    
    DMPRINT(@"找到外围设备的服务特性:%@", _characteristicUUID);
    if (_actionType == BLUETOOTH_ACTION_WRITE) {
        [peripheral writeValue:_data forCharacteristic:currentCharacteristic type:CBCharacteristicWriteWithResponse];
    }
}

/*!
 *  当外围设备写入数据后，激活此调用
 *
 *  @param peripheral     外围设备
 *  @param characteristic 服务特性
 *  @param error          错误描述
 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    DMPRINTMETHODNAME();
    
    if (privateActionBlock) {
        privateActionBlock(peripheral, characteristic, error);
    }
    
    if (error)
    {
        DMPRINT(@"写入服务特性 %@ 错误: %@", characteristic.UUID, [error localizedDescription]);
        return;
    }
    DMPRINT(@"写入服务特性:%@ 成功", _characteristicUUID);
}

@end
