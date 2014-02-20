//
//  BleDriven.h
//  iColorLed
//
//  Created by 金磊 on 13-11-17.
//  Copyright (c) 2013年 lordking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol BLECentralDrivenDelegate <NSObject>

@optional

/*!
 *  获得发现的外围设备
 *
 *  @param dicoveredPeripherals 被发现的所有设备
 */
- (void)getDiscoveredPeripherals:(NSMutableArray *)dicoveredPeripherals;

/*!
 *  获得一个外围设备发现的服务。当调用connectPeripheralWithUUID、writeData、notfiyData时，可使用该接口
 *
 *  @param discoveredServices 被发现的服务
 */
- (void)getDiscoveredServices:(NSArray *)discoveredServices withPeripheral:(CBPeripheral *)peripheral;

/*!
 *  获得一个外围设备的一个服务下的服务特性。当调用connectPeripheralWithUUID、writeData、notfiyData时，可使用该接口
 *
 *  @param discoveredCharacteristics 被发现的所有服务特性
 */
- (void)getDiscoveredCharacteristics:(NSArray *)discoveredCharacteristics withService:(CBService*)service Peripheral:(CBPeripheral *)peripheral;


@end

//定义蓝牙连接状态
typedef enum
{
    BLUETOOTH_STATUS_ERROR_CONNECTED = -1,
    BLUETOOTH_STATUS_DISCONNECTED = 0,
    BLUETOOTH_STATUS_FAIL_TO_CONNECT = 1,
    BLUETOOTH_STATUS_CONNECTED = 2
}BLUETOOTH_STATUS;

//定义操作动作
typedef enum
{
    BLUETOOTH_ACTION_WRITE = 1
}BLUETOOTH_ACTION_TYPE;

//定义一个连接外围设备的回调程序块
typedef void (^eventConnectBlock)(CBPeripheral *peripheral, BLUETOOTH_STATUS status, NSError *error);

//定义一个调用服务特性的回调程序块
typedef void (^eventActionBlock)(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error);

@interface BLECentralDriven : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>
{
    NSMutableArray *dicoveredPeripherals;
    CBCentralManager *manager;
    
@private
    
    CBUUID *_serviceUUID;
    CBUUID *_characteristicUUID;
    NSData *_data;
    BLUETOOTH_ACTION_TYPE _actionType;
}

+ (BLECentralDriven *)shared;
- (void)startScanWithServices:(NSArray *)servicesCBUUID;
- (void)stopScan;
- (void)connectPeripheralWithUUID:(NSUUID*)uuid;
- (void)disconnectPeripheralWithUUID:(NSUUID*)uuid;
- (void)connectResponse:(eventConnectBlock)block;
- (void)writeData:(NSData*)data forCharacteristic:(CBUUID*)characteristicUUID service: (CBUUID*)serviceUUID peripheral: (NSUUID*)peripheralUUID;
- (void)actionResponse:(eventActionBlock)block;

@property (nonatomic, weak) id<BLECentralDrivenDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *dicoveredPeripherals;
@property (nonatomic, strong) CBCentralManager *manager;

//私有变量声明
@property (nonatomic, strong) CBUUID *_serviceUUID;
@property (nonatomic, strong) CBUUID *_characteristicUUID;
@property (nonatomic, strong) NSData *_data;
@property (nonatomic) BLUETOOTH_ACTION_TYPE _actionType;
@end
