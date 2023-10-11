#if !os(watchOS)
import CallKit

public protocol CallsObserver: AnyObject {
    /**
     * Callback when a call event is recorded (received, made, missed)
     *
     * @param data
     */
    func onCall(data: CallsData)
    
    /**
     * Callback when the phone is ringing
     *
     * @param number
     */
    func onRinging(number: String?)
    
    /**
     * Callback when the user answered and is busy with a call
     *
     * @param number
     */
    func onBusy(number: String?)
    
    /**
     * Callback when the user hangup an ongoing call and is now free
     *
     * @param number
     */
    func onFree(number: String?)
}

public class CallsSensor: NSObject, ISensorController {

    public enum CallEventType: Int {
        case incoming  = 1
        case outgoing  = 2
        case missed    = 3
        case voiceMail = 4
        case rejected  = 5
        case blocked   = 6
        case answeredExternally = 7
        
        var stringValue: String {
            switch self {
            
            case .incoming:
                return "incoming"
            case .outgoing:
                return "outgoing"
            case .missed:
                return "missed"
            case .voiceMail:
                return "voicemail"
            case .rejected:
                return "rejected"
            case .blocked:
                return "blocked"
            case .answeredExternally:
                return "external"
            }
        }
    }
    
    public var config = Config()
    
    var callObserver: CXCallObserver? = nil
    
    var lastCallEvent:CXCall? = nil
    var lastCallEventTime:Date? = nil
    var lastCallEventType: CallEventType? = nil
    
    public class Config:SensorConfig {
        public weak var sensorObserver: CallsObserver?
        
        public override init(){
            super.init()
        }
        
        public func apply(closure:(_ config: CallsSensor.Config) -> Void) -> Self {
            closure(self)
            return self
        }
    }
    
    public override convenience init(){
        self.init(CallsSensor.Config())
    }
    
    public init(_ config:CallsSensor.Config){
        super.init()
        self.config = config
    }
    
    public func start() {
        if callObserver == nil {
            callObserver = CXCallObserver()
            callObserver!.setDelegate(self, queue: nil)
        }
    }
    
    public func stop() {
        if callObserver != nil {
            callObserver = nil
        }
    }
}

/**
 * INCOMING_TYPE = 1
 * OUTGOING_TYPE = 2
 * MISSED_TYPE = 3
 * VOICEMAIL_TYPE = 4
 * REJECTED_TYPE = 5
 * BLOCKED_TYPE = 6
 * ANSWERED_EXTERNALLY_TYPE = 7
 */

extension CallsSensor: CXCallObserverDelegate {
    /**
     * http://www.yuukinishiyama.com/2018/10/25/handling-phone-call-events-on-ios-using-swift-4/
     * https://stackoverflow.com/questions/36014975/detect-phone-calls-on-ios-with-ctcallcenter-swift
     */
    public func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        print(call.isOutgoing, call.isOnHold, call.hasEnded, call.hasConnected)
        if call.hasEnded == true && call.isOutgoing == false || // in-coming end
           call.hasEnded == true && call.isOutgoing == true {   // out-going end
            if self.config.debug { print("Disconnected") }
            if let observer = self.config.sensorObserver{
                observer.onFree(number: call.uuid.uuidString)
            }
            print("call save")
            self.save(call:call)
        }

        if call.isOutgoing == true && call.hasConnected == false && call.hasEnded == false {
            if self.config.debug { print("Dialing") }
            if let observer = self.config.sensorObserver{
                observer.onRinging(number: call.uuid.uuidString)
            }
            lastCallEventType = CallEventType.outgoing
        }
        
        if call.isOutgoing == false && call.hasConnected == false && call.hasEnded == false {
            if self.config.debug { print("Incoming") }
            if let observer = self.config.sensorObserver{
                observer.onRinging(number: call.uuid.uuidString)
            }
            lastCallEventType = CallEventType.incoming
        }
        
        if call.hasConnected == true && call.hasEnded == false {
            if self.config.debug { print("Connected") }
            if let observer = self.config.sensorObserver{
                observer.onBusy(number: call.uuid.uuidString)
            }
            //self.notificationCenter.post(name: .actionLampCallAccepted, object: self)
            //self.notificationCenter.post(name: .actionLampCallUserInCall, object: self)
            print("lastCallEvent daved")
            lastCallEvent = call
            lastCallEventTime = Date()
            if call.isOutgoing {
                lastCallEventType = CallEventType.outgoing
            } else {
                lastCallEventType = CallEventType.incoming
            }
        }
    }
    
    public func save(call: CXCall){
        if let uwLastCallEvent = self.lastCallEvent,
           let uwLastCallEventTime = self.lastCallEventTime,
           let uwLastCallEventType = self.lastCallEventType {
            
            let now = Date()
            let data = CallsData()
            data.timestamp = Date().timeIntervalSince1970 * 1000
            //data.trace = uwLastCallEvent.uuid.uuidString
            data.duration = now.timeIntervalSince1970.toMilliSeconds - uwLastCallEventTime.timeIntervalSince1970.toMilliSeconds
            data.type = uwLastCallEventType.stringValue

            self.config.sensorObserver?.onCall(data: data)
            // data.type = eventType
            self.lastCallEvent = nil
            lastCallEventTime = nil
            lastCallEventType = nil
        } else {
            print("something nil")
        }
    }
}
#endif
