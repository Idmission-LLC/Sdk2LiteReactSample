import * as React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import ResultScreen from './Home/ResultScreen'
import Home from './Home/Home'

const Stack = createStackNavigator();

function App() {
  return (
    <NavigationContainer >
      <Stack.Navigator screenOptions={{ initialRouteName: "Home", headerShown: false }}>
     
        <Stack.Screen name="Home" component={Home} />
        <Stack.Screen name="ResultScreen" component={ResultScreen} />
      
      </Stack.Navigator>
    </NavigationContainer>
  );
}

export default App;