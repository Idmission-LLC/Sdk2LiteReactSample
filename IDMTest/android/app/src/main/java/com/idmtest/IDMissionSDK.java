package com.idmtest;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.idmission.sdk2.capture.IdMissionCaptureLauncher;
import com.idmission.sdk2.capture.presentation.camera.helpers.ProcessedCapture;
import com.idmission.sdk2.client.model.CommonApiResponse;
import com.idmission.sdk2.client.model.ExtractedIdData;
import com.idmission.sdk2.client.model.ExtractedPersonalData;
import com.idmission.sdk2.client.model.HostDataResponse;
import com.idmission.sdk2.client.model.InitializeResponse;
import com.idmission.sdk2.client.model.Response;
import com.idmission.sdk2.client.model.ResponseCustomerData;
import com.idmission.sdk2.client.model.UiCustomizationOptions;
import com.idmission.sdk2.identityproofing.IdentityProofingSDK;
import com.idmission.sdk2.utils.LANGUAGE;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class IDMissionSDK extends ReactContextBaseJavaModule implements ActivityEventListener {
    String InitializeApiBaseUrl = "https://demo.idmission.com/";
    String ApiBaseUrl = "https://apidemo.idmission.com/";
    String LoginID = "";
    String Password = "";
    long MerchantID = 0;
    private List<ProcessedCapture> processedCaptures = new ArrayList<>();
    private IdMissionCaptureLauncher launcher = new IdMissionCaptureLauncher();
    ReactApplicationContext reactContext;

    //constructor
    public IDMissionSDK(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        this.reactContext.addActivityEventListener(this);
    }

    @Override
    public String getName() {
        return "IDMissionSDK";
    }

    @ReactMethod
    public void  initializeSDK(String initializeURL, String url, String loginID, String password, String merchantID) {
        if(!StringUtils.isEmpty(initializeURL)){
            InitializeApiBaseUrl = initializeURL;
        }
        if(!StringUtils.isEmpty(url)){
            ApiBaseUrl = url;
        }
        if(!StringUtils.isEmpty(loginID)){
            LoginID = loginID;
        }
        if(!StringUtils.isEmpty(password)){
            Password = password;
        }
        if(!StringUtils.isEmpty(merchantID)){
            MerchantID = Long.parseLong(merchantID);
        }
        new BackgroundTask().execute();
    }

    @ReactMethod
    public void  serviceID20() {
        new AlertDialog.Builder(getReactApplicationContext().getCurrentActivity())
                .setTitle("Capture Back?")
                .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        IdentityProofingSDK.INSTANCE.idValidation(getReactApplicationContext().getCurrentActivity(), true);
                    }
                })
                .setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        IdentityProofingSDK.INSTANCE.idValidation(getReactApplicationContext().getCurrentActivity(), false);
                    }
                })
                .setIcon(android.R.drawable.ic_dialog_info)
                .show();
    }

    @ReactMethod
    public void  serviceID10() {
        new AlertDialog.Builder(getReactApplicationContext().getCurrentActivity())
                .setTitle("Capture Back?")
                .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        IdentityProofingSDK.INSTANCE.idValidationAndMatchFace(getReactApplicationContext().getCurrentActivity(), true);
                    }
                })
                .setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        IdentityProofingSDK.INSTANCE.idValidationAndMatchFace(getReactApplicationContext().getCurrentActivity(), false);
                    }
                })
                .setIcon(android.R.drawable.ic_dialog_info)
                .show();
    }

    @ReactMethod
    public void  serviceID185() {
        IdentityProofingSDK.INSTANCE.identifyCustomer(getReactApplicationContext().getCurrentActivity(), null, null);
    }

    @ReactMethod
    public void  serviceID660() {
        IdentityProofingSDK.INSTANCE.liveFaceCheck(getReactApplicationContext().getCurrentActivity());
    }

    @ReactMethod
    public void  serviceID50(String uniqueCustomerNumber) {
        if(!StringUtils.isEmpty(uniqueCustomerNumber)){
            new AlertDialog.Builder(getReactApplicationContext().getCurrentActivity())
                    .setTitle("Capture Back?")
                    .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int which) {
                            IdentityProofingSDK.INSTANCE.idValidationAndcustomerEnroll(getReactApplicationContext().getCurrentActivity(), uniqueCustomerNumber, true);
                        }
                    })
                    .setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int which) {
                            IdentityProofingSDK.INSTANCE.idValidationAndcustomerEnroll(getReactApplicationContext().getCurrentActivity(), uniqueCustomerNumber, false);
                        }
                    })
                    .setIcon(android.R.drawable.ic_dialog_info)
                    .show();
        }
    }

    @ReactMethod
    public void  serviceID175(String uniqueCustomerNumber) {
        if(!StringUtils.isEmpty(uniqueCustomerNumber)){
            IdentityProofingSDK.INSTANCE.customerEnrollBiometrics(getReactApplicationContext().getCurrentActivity(), uniqueCustomerNumber);
        }
    }

    @ReactMethod
    public void  serviceID105(String uniqueCustomerNumber) {
        if(!StringUtils.isEmpty(uniqueCustomerNumber)){
            IdentityProofingSDK.INSTANCE.customerVerification(getReactApplicationContext().getCurrentActivity(), uniqueCustomerNumber);
        }
    }

    @ReactMethod
    public void submitResult(){
        new FinalSubmitTask().execute();
    }

    class BackgroundTask extends AsyncTask<Void, Void, Response<InitializeResponse>> {

        @Override
        protected void onPostExecute(Response<InitializeResponse> initializeResponseResponse) {
            super.onPostExecute(initializeResponseResponse);
            WritableMap params = Arguments.createMap();
            params.putString("data",initializeResponseResponse.getResult().toString());
            sendEvent(getReactApplicationContext(), "DataCallback", params);
        }

        @Override
        protected Response<InitializeResponse> doInBackground(Void... voids) {
            Response<InitializeResponse> response =
                    IdentityProofingSDK.INSTANCE.initialize(getReactApplicationContext().getCurrentActivity(),
                            InitializeApiBaseUrl,
                            ApiBaseUrl,
                            LoginID,
                            Password,
                            MerchantID,
                            false,
                            true,
                            new UiCustomizationOptions(LANGUAGE.valueOf("EN"),
                                    null,
                                    null,
                                    null,
                                    null,
                                    null,
                                    "Document not detected. Please try again.",
                                    "Face not detected. Please try again.",
                                    getReactApplicationContext().getColor(R.color.colorPrimary),
                                    getReactApplicationContext().getColor(R.color.colorPrimary),
                                    null
                            ));
            return response;
        }
    }

    class FinalSubmitTask extends AsyncTask<Void, Void, Response<CommonApiResponse>> {

        @Override
        protected void onPostExecute(Response<CommonApiResponse> apiResponse) {
            super.onPostExecute(apiResponse);
            if(apiResponse.getErrorStatus()!=null) {
                WritableMap params = Arguments.createMap();
                params.putString("data",apiResponse.getErrorStatus().getStatusMessage());
                sendEvent(getReactApplicationContext(), "DataCallback", params);
            } else  {
                WritableMap params = Arguments.createMap();
                params.putString("data",parseResponse(apiResponse));
                sendEvent(getReactApplicationContext(), "DataCallback", params);
            }
        }

        @Override
        protected Response<CommonApiResponse> doInBackground(Void... voids) {

            Response<CommonApiResponse> response =
                    IdentityProofingSDK.INSTANCE.finalSubmit(getReactApplicationContext().getCurrentActivity());

            return response;
        }
    }

    @Override
    public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
        if (data != null) {
            if (requestCode == IdMissionCaptureLauncher.CAPTURE_REQUEST_CODE) {
                try{
                    //processedCaptures = launcher.processResult(data);
                    WritableMap params = Arguments.createMap();
                    params.putString("data","Success");
                    sendEvent(getReactApplicationContext(), "DataCallback", params);
                }catch(Exception e){
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public void onNewIntent(Intent intent) {}

    private void sendEvent(ReactApplicationContext reactContext,
                           String eventName,
                           @Nullable WritableMap params) {
        reactContext
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, params);
    }

    private String parseResponse(Response<CommonApiResponse> response){
        JSONObject jo = new JSONObject();
        try {
            jo.put("AdditionalData", response.getResult().getAdditionalData());
        }catch(Exception e){}
        try {
            JSONObject responseCustomerData = new JSONObject();
            JSONObject extractedIdData = new JSONObject();
            JSONObject extractedPersonalData = new JSONObject();

            ResponseCustomerData rcd = response.getResult().getResponseCustomerData();

            ExtractedIdData eid = rcd.getExtractedIdData();
            extractedIdData.put("BarcodeDataParsed",eid.getBarcodeDataParsed());
            extractedIdData.put("IdCountry",eid.getIdCountry());
            extractedIdData.put("IdDateOfBirth",eid.getIdDateOfBirth());
            extractedIdData.put("IdDateOfBirthFormatted",eid.getIdDateOfBirthFormatted());
            extractedIdData.put("IdDateOfBirthNonEng",eid.getIdDateOfBirthNonEng());
            extractedIdData.put("IdExpirationDate",eid.getIdExpirationDate());
            extractedIdData.put("IdExpirationDateFormatted",eid.getIdExpirationDateFormatted());
            extractedIdData.put("IdExpirationDateNonEng",eid.getIdExpirationDateNonEng());
            extractedIdData.put("IdIssueCountry",eid.getIdIssueCountry());
            extractedIdData.put("IdIssueDate",eid.getIdIssueDate());
            extractedIdData.put("IdIssueDateNonEng",eid.getIdIssueDateNonEng());
            extractedIdData.put("IdNumber",eid.getIdNumber());
            extractedIdData.put("IdNumberNonEng",eid.getIdNumberNonEng());
            extractedIdData.put("IdNumber1",eid.getIdNumber1());
            extractedIdData.put("IdNumber2",eid.getIdNumber2());
            extractedIdData.put("IdNumber2NonEng",eid.getIdNumber2NonEng());
            extractedIdData.put("IdNumber3",eid.getIdNumber3());
            extractedIdData.put("IdState",eid.getIdState());
            extractedIdData.put("IdType",eid.getIdType());
            extractedIdData.put("MrzData",eid.getMrzData());

            responseCustomerData.put("ExtractedIdData",extractedIdData);

            ExtractedPersonalData epd = rcd.getExtractedPersonalData();
            extractedPersonalData.put("AddressLine1",epd.getAddressLine1());
            extractedPersonalData.put("AddressLine1NonEng",epd.getAddressLine1NonEng());
            extractedPersonalData.put("AddressLine2",epd.getAddressLine2());
            extractedPersonalData.put("AddressLine2NonEng",epd.getAddressLine2NonEng());
            extractedPersonalData.put("City",epd.getCity());
            extractedPersonalData.put("AddressNonEng",epd.getAddressNonEng());
            extractedPersonalData.put("Country",epd.getCountry());
            extractedPersonalData.put("District",epd.getDistrict());
            extractedPersonalData.put("Dob",epd.getDob());
            extractedPersonalData.put("Email",epd.getEmail());
            extractedPersonalData.put("EnrolledDate",epd.getEnrolledDate());
            extractedPersonalData.put("FirstName",epd.getFirstName());
            extractedPersonalData.put("FirstNameNonEng",epd.getFirstNameNonEng());
            extractedPersonalData.put("Gender",epd.getGender());
            extractedPersonalData.put("LastName",epd.getLastName());
            extractedPersonalData.put("LastName2",epd.getLastName2());
            extractedPersonalData.put("LastNameNonEng",epd.getLastNameNonEng());
            extractedPersonalData.put("Name",epd.getName());
            extractedPersonalData.put("Phone",epd.getPhone());
            extractedPersonalData.put("UniqueNumber",epd.getUniqueNumber());
            extractedPersonalData.put("MiddleName",epd.getMiddleName());
            extractedPersonalData.put("MiddleNameNonEng",epd.getMiddleNameNonEng());

            responseCustomerData.put("ExtractedPersonalData",extractedPersonalData);

            HostDataResponse hdr = rcd.getHostData();
            responseCustomerData.put("HostDataResponse",hdr);

            jo.put("ResponseCustomerData", responseCustomerData);
        }catch(Exception e){}
        try {
            JSONObject responseCustomerVerifyData = new JSONObject();
            JSONObject extractedIdData = new JSONObject();
            JSONObject extractedPersonalData = new JSONObject();

            ResponseCustomerData rcvd = response.getResult().getResponseCustomerVerifyData();

            ExtractedIdData eid = rcvd.getExtractedIdData();
            extractedIdData.put("BarcodeDataParsed",eid.getBarcodeDataParsed());
            extractedIdData.put("IdCountry",eid.getIdCountry());
            extractedIdData.put("IdDateOfBirth",eid.getIdDateOfBirth());
            extractedIdData.put("IdDateOfBirthFormatted",eid.getIdDateOfBirthFormatted());
            extractedIdData.put("IdDateOfBirthNonEng",eid.getIdDateOfBirthNonEng());
            extractedIdData.put("IdExpirationDate",eid.getIdExpirationDate());
            extractedIdData.put("IdExpirationDateFormatted",eid.getIdExpirationDateFormatted());
            extractedIdData.put("IdExpirationDateNonEng",eid.getIdExpirationDateNonEng());
            extractedIdData.put("IdIssueCountry",eid.getIdIssueCountry());
            extractedIdData.put("IdIssueDate",eid.getIdIssueDate());
            extractedIdData.put("IdIssueDateNonEng",eid.getIdIssueDateNonEng());
            extractedIdData.put("IdNumber",eid.getIdNumber());
            extractedIdData.put("IdNumberNonEng",eid.getIdNumberNonEng());
            extractedIdData.put("IdNumber1",eid.getIdNumber1());
            extractedIdData.put("IdNumber2",eid.getIdNumber2());
            extractedIdData.put("IdNumber2NonEng",eid.getIdNumber2NonEng());
            extractedIdData.put("IdNumber3",eid.getIdNumber3());
            extractedIdData.put("IdState",eid.getIdState());
            extractedIdData.put("IdType",eid.getIdType());
            extractedIdData.put("MrzData",eid.getMrzData());

            responseCustomerVerifyData.put("ExtractedIdData",extractedIdData);

            ExtractedPersonalData epd = rcvd.getExtractedPersonalData();
            extractedPersonalData.put("AddressLine1",epd.getAddressLine1());
            extractedPersonalData.put("AddressLine1NonEng",epd.getAddressLine1NonEng());
            extractedPersonalData.put("AddressLine2",epd.getAddressLine2());
            extractedPersonalData.put("AddressLine2NonEng",epd.getAddressLine2NonEng());
            extractedPersonalData.put("City",epd.getCity());
            extractedPersonalData.put("AddressNonEng",epd.getAddressNonEng());
            extractedPersonalData.put("Country",epd.getCountry());
            extractedPersonalData.put("District",epd.getDistrict());
            extractedPersonalData.put("Dob",epd.getDob());
            extractedPersonalData.put("Email",epd.getEmail());
            extractedPersonalData.put("EnrolledDate",epd.getEnrolledDate());
            extractedPersonalData.put("FirstName",epd.getFirstName());
            extractedPersonalData.put("FirstNameNonEng",epd.getFirstNameNonEng());
            extractedPersonalData.put("Gender",epd.getGender());
            extractedPersonalData.put("LastName",epd.getLastName());
            extractedPersonalData.put("LastName2",epd.getLastName2());
            extractedPersonalData.put("LastNameNonEng",epd.getLastNameNonEng());
            extractedPersonalData.put("Name",epd.getName());
            extractedPersonalData.put("Phone",epd.getPhone());
            extractedPersonalData.put("UniqueNumber",epd.getUniqueNumber());
            extractedPersonalData.put("MiddleName",epd.getMiddleName());
            extractedPersonalData.put("MiddleNameNonEng",epd.getMiddleNameNonEng());

            responseCustomerVerifyData.put("ExtractedPersonalData",extractedPersonalData);

            HostDataResponse hdr = rcvd.getHostData();
            responseCustomerVerifyData.put("HostDataResponse",hdr);

            jo.put("ResponseCustomerVerifyData", responseCustomerVerifyData);
        }catch(Exception e){}
        try {
            jo.put("ResultData", response.getResult().getResultData());
        }catch(Exception e){}
        try {
            jo.put("Status", response.getResult().getStatus());
        }catch(Exception e){}

        return jo.toString();
    }
}
