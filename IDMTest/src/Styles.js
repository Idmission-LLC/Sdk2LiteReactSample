import { StyleSheet } from 'react-native'
import * as constant from './Constant'
const styles = StyleSheet.create({

    audioButton:{
                     
        borderWidth:1.5,
        height:constant.deviceWidth*10/100,
        width:constant.deviceWidth*20/100,
        alignItems:'center',
        justifyContent:'center',
        borderRadius:10,
        borderColor:constant.whiteColor,

        },
        audioText:{
            color:constant.whiteColor,
            fontSize:constant.fontSize2
        },
        audioImage:{
            height:constant.deviceWidth*50/100,
            width:constant.deviceWidth*90/100,
            marginHorizontal:'5%',
            justifyContent:'flex-end',
        },
        audioContent:{
            flex:1,
            justifyContent:'center',
        },

    dropDownView: {
        color: constant.blackColor,
        flexDirection: "row",
        alignItems: "center",
        borderBottomWidth: 1,
        marginHorizontal: '8%',
        height:100,
        width:300,
        borderBottomColor: constant.lightGrayColor,
    },
    startButton: {
        borderWidth: constant.borderWidth1,
        marginHorizontal: '5%',
        alignItems: 'baseline',
        justifyContent: 'center',
        height: constant.deviceWidth * 15 / 100,
        borderRadius: 10,
        marginTop: 10,
        paddingLeft: 10,
        borderColor: constant.baseColor,
        backgroundColor: constant.baseColor,

    },
    startButtonText: {
        fontSize: constant.fontSize1,
        color: constant.whiteColor
    },
    mainText: {
        color: constant.blackColor,
        fontSize: constant.fontSize1
    },
    keyButton: {
        justifyContent: 'center',
        height: 30,
        borderRadius: 10,
        marginLeft: 10,
        marginRight: 10,
        paddingLeft: 12,
        paddingRight: 12,
        borderColor: constant.baseColor,
        backgroundColor: constant.baseColor,

    },
    keyButtonText: {
        fontSize: 15,
        color: constant.whiteColor
    },    
    imageStyle: {
        height: constant.deviceHeight * 80 / 100,
        width: constant.deviceWidth * 90 / 100,
        borderColor: 'red'
    },
    cardDetectImage:{
        height: constant.deviceHeight * 50 / 100,
        width: constant.deviceWidth * 90 / 100,
    },
    cardDetectText:{
       fontSize:1.2*constant.fontSize3,
       marginLeft:'4%',
       marginBottom:'1%',
    },
    cardDetectText2:{
        fontSize:constant.fontSize2,
        marginVertical:'4%',

    },
    input: {
        height: 40,
        margin: 12,
        borderWidth: 1,
        padding: 10,
    },
    gpsText:{
        fontSize:constant.fontSize2
    }

})

export default styles
