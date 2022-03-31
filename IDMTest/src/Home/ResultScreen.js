import React from 'react'
import { View, TouchableOpacity, Text, Image } from 'react-native'
import { Container, Header, Content, Picker, Left, Icon, Body,Button} from "native-base";
import * as constant from '../Constant'
import styles from '../Styles'


export default class ResultScreen extends React.Component {

    constructor(props){
        super(props)
        this.state={
            data:'P',
            longitude:'',
            latitude:''
        }
    }
    componentDidMount=()=>{
        console.log("event:"+this.props.route.params.eventResponse);

        if(this.props.route.params.eventName=="Data"){
            var data1 = JSON.stringify(this.props.route.params.eventResponse);
            this.setState({data:data1})
        }
    }
    render() {
        return (
            <Container>
                <Header style={{ backgroundColor: constant.baseColor }}>
                    <Left>
                        <Button transparent onPress={()=>this.props.navigation.goBack()}>
                            <Text style={styles.mainText}>Back</Text>
                        </Button>
                    </Left>
                    <Body>

                    </Body>
                </Header>
                <Content contentContainerStyle={{ flex: 1, justifyContent: 'center' }}>
                    {
                        (this.props.route.params.eventName=="Data")?
                        (
                            <View style={{ flex: 1 }}>
                            <Text style={styles.mainText}>Response :{this.state.data}</Text>
                            </View>
                        ):
                        null
                    }
                    {
                        (this.props.route.params.eventName=="Image")?
                        (
                            <View>
                            <Image source={{ uri: "data:image/png;base64," + this.props.route.params.eventResponse }}
                                style={styles.imageStyle}
                                resizeMode="contain"
                            ></Image>
                        </View>
                        ):
                        null
                    }
                </Content>
            </Container>

        )
    }
}
