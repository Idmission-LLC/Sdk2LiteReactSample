import React from 'react'
import { View, TouchableOpacity, Text, Image, Platform } from 'react-native'
import { Container, Header, Content, Picker } from "native-base";
import * as constant from '../Constant'
import styles from '../Styles'
import { NativeModules, NativeEventEmitter } from 'react-native';
import { TextInput } from "react-native";
import { LogBox } from 'react-native';

LogBox.ignoreLogs(['new NativeEventEmitter']);
LogBox.ignoreLogs(['Warning: ...']);
LogBox.ignoreAllLogs(); 
const { IDMissionSDK } = NativeModules;

var initialize_url = "";
var url = "";
var login_id = "";
var password = "";
var merchant_id = "";

export default class Home extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            selected: '',
            images: '',
            uniqueCustomerNumber: '',
            event: [
                "Select Feature"
            ]
        }
    }

    componentDidMount() {

        IDMissionSDK.initializeSDK(
            initialize_url,
            url,
            login_id,
            password,
            merchant_id
        );

        const eventEmitter = new NativeEventEmitter(IDMissionSDK);

        eventEmitter.addListener('onSessionConnect', (event) => { });

        eventEmitter.addListener('DataCallback', (event) => {
            console.log("Responsde")
            var data = JSON.stringify(event);
            this.props.navigation.navigate("ResultScreen", { eventResponse: event, eventName: "Data" })
        });

    }

    onServiceID20 = () => {
        IDMissionSDK.serviceID20();
    }

    onServiceID10 = () => {
        IDMissionSDK.serviceID10();
    }

    onServiceID50 = () => {
	   IDMissionSDK.serviceID50(this.state.uniqueCustomerNumber);	
    }

    onServiceID175 = () => {
        IDMissionSDK.serviceID175(this.state.uniqueCustomerNumber);
    }

    onServiceID105 = () => {
        IDMissionSDK.serviceID105(this.state.uniqueCustomerNumber);
    }

    onServiceID185 = () => {
        IDMissionSDK.serviceID185();
    }
         
    onServiceID660 = () => {
        IDMissionSDK.serviceID660();
    }
	
	onSubmit = () => {
        IDMissionSDK.submitResult();
    }

    press1 = () => {
        this.state.uniqueCustomerNumber = this.state.uniqueCustomerNumber + 1;
        this.setState({
          uniqueCustomerNumber: this.state.uniqueCustomerNumber
        })
    }

    press2 = () => {
        this.state.uniqueCustomerNumber = this.state.uniqueCustomerNumber + 2;
        this.setState({
          uniqueCustomerNumber: this.state.uniqueCustomerNumber
        })        
    }

    press3 = () => {
        this.state.uniqueCustomerNumber = this.state.uniqueCustomerNumber + 3;
        this.setState({
          uniqueCustomerNumber: this.state.uniqueCustomerNumber
        })        
    }

    press4 = () => {
        this.state.uniqueCustomerNumber = this.state.uniqueCustomerNumber + 4;
        this.setState({
          uniqueCustomerNumber: this.state.uniqueCustomerNumber
        })        
    }

    press5 = () => {
        this.state.uniqueCustomerNumber = this.state.uniqueCustomerNumber + 5;
        this.setState({
          uniqueCustomerNumber: this.state.uniqueCustomerNumber
        })        
    }

    press6 = () => {
        this.state.uniqueCustomerNumber = this.state.uniqueCustomerNumber + 6;
        this.setState({
          uniqueCustomerNumber: this.state.uniqueCustomerNumber
        })        
    }    

    press7 = () => {
        this.state.uniqueCustomerNumber = this.state.uniqueCustomerNumber + 7;
        this.setState({
          uniqueCustomerNumber: this.state.uniqueCustomerNumber
        })        
    }

    press8 = () => {
        this.state.uniqueCustomerNumber = this.state.uniqueCustomerNumber + 8;
        this.setState({
          uniqueCustomerNumber: this.state.uniqueCustomerNumber
        })        
    }

    press9 = () => {
        this.state.uniqueCustomerNumber = this.state.uniqueCustomerNumber + 9;
        this.setState({
          uniqueCustomerNumber: this.state.uniqueCustomerNumber
        })        
    }    

    press0 = () => {
        this.state.uniqueCustomerNumber = this.state.uniqueCustomerNumber + 0;
        this.setState({
          uniqueCustomerNumber: this.state.uniqueCustomerNumber
        })        
    }

    pressDel = () => {
        this.state.uniqueCustomerNumber = '';
        this.setState({
          uniqueCustomerNumber: this.state.uniqueCustomerNumber
        })        
    }

    render() {
        return (
            <Container>
			
                <Content contentContainerStyle={{ justifyContent: 'center' }}>
				    <Content contentContainerStyle={{ justifyContent: 'flex-start', flexDirection: 'row', marginLeft: 25, marginRight: 15, padding:10 }}>
                        
                        <Text style={styles.mainText}>Unique Customer Number - </Text>

                        <Text style={styles.mainText}>{this.state.uniqueCustomerNumber}</Text>

                    </Content>

                    <Content contentContainerStyle={{ justifyContent: 'flex-start', flexDirection: 'row', marginLeft: 15, marginRight: 15, padding:10 }}>

                        <TouchableOpacity style={styles.keyButton} onPress={() => { this.press1() }}>
                            <Text style={styles.keyButtonText}>1</Text>
                        </TouchableOpacity>

                        <TouchableOpacity style={styles.keyButton} onPress={() => { this.press2() }}>
                            <Text style={styles.keyButtonText}>2</Text>
                        </TouchableOpacity>

                        <TouchableOpacity style={styles.keyButton} onPress={() => { this.press3() }}>
                            <Text style={styles.keyButtonText}>3</Text>
                        </TouchableOpacity>

                        <TouchableOpacity style={styles.keyButton} onPress={() => { this.press4() }}>
                            <Text style={styles.keyButtonText}>4</Text>
                        </TouchableOpacity>                        

                        <TouchableOpacity style={styles.keyButton} onPress={() => { this.press5() }}>
                            <Text style={styles.keyButtonText}>5</Text>
                        </TouchableOpacity>

                    </Content>

                    <Content contentContainerStyle={{ justifyContent: 'flex-start', flexDirection: 'row', marginLeft: 15, marginRight: 15, padding:10 }}>

                        <TouchableOpacity style={styles.keyButton} onPress={() => { this.press6() }}>
                            <Text style={styles.keyButtonText}>6</Text>
                        </TouchableOpacity> 

                        <TouchableOpacity style={styles.keyButton} onPress={() => { this.press7() }}>
                            <Text style={styles.keyButtonText}>7</Text>
                        </TouchableOpacity>

                        <TouchableOpacity style={styles.keyButton} onPress={() => { this.press8() }}>
                            <Text style={styles.keyButtonText}>8</Text>
                        </TouchableOpacity>

                        <TouchableOpacity style={styles.keyButton} onPress={() => { this.press9() }}>
                            <Text style={styles.keyButtonText}>9</Text>
                        </TouchableOpacity>

                         <TouchableOpacity style={styles.keyButton} onPress={() => { this.press0() }}>
                            <Text style={styles.keyButtonText}>0</Text>
                        </TouchableOpacity>   

                        <TouchableOpacity style={styles.keyButton} onPress={() => { this.pressDel() }}>
                            <Text style={styles.keyButtonText}>Del</Text>
                        </TouchableOpacity>            

                    </Content>

                    <TouchableOpacity style={styles.startButton} onPress={() => { this.onServiceID20() }}>
                        <Text style={styles.startButtonText}>ID Validation</Text>
                    </TouchableOpacity>

                    <TouchableOpacity style={styles.startButton} onPress={() => { this.onServiceID10() }}>
                        <Text style={styles.startButtonText}>ID Validation and Match Face</Text>
                    </TouchableOpacity>

                    <TouchableOpacity style={styles.startButton} onPress={() => { this.onServiceID50() }}>
                        <Text style={styles.startButtonText}>ID Validation and Customer Enroll</Text>
                    </TouchableOpacity>

                    <TouchableOpacity style={styles.startButton} onPress={() => { this.onServiceID175() }}>
                        <Text style={styles.startButtonText}>Customer Enroll Biometrics</Text>
                    </TouchableOpacity>

                    <TouchableOpacity style={styles.startButton} onPress={() => { this.onServiceID105() }}>
                        <Text style={styles.startButtonText}>Customer Verification</Text>
                    </TouchableOpacity>

                    <TouchableOpacity style={styles.startButton} onPress={() => { this.onServiceID185() }}>
                        <Text style={styles.startButtonText}>Identify Customer</Text>
                    </TouchableOpacity>                    

                    <TouchableOpacity style={styles.startButton} onPress={() => { this.onServiceID660() }}>
                        <Text style={styles.startButtonText}>Live Face Check</Text>
                    </TouchableOpacity>                

                    <TouchableOpacity style={styles.startButton} onPress={() => { this.onSubmit() }}>
                        <Text style={styles.startButtonText}>Submit</Text>
                    </TouchableOpacity>  

                </Content>
            </Container>
        )
    }
}
