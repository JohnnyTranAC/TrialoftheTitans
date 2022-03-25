/************************************************************
 * Done by: Mohammed Azad
 * Contains functionality to deal with the education
 * component
 * Date: March 24 2022
 ************************************************************/

import { LightningElement, track, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import EDUCATION_OBJECT from '@salesforce/schema/Education__c';
import USER_FIELD from '@salesforce/schema/Education__c.User__c';
import EDUCATION_FIELD from '@salesforce/schema/Education__c.Name';
import GPA_FIELD from '@salesforce/schema/Education__c.Gpa__c';
import MAJOR_FIELD from '@salesforce/schema/Education__c.Major__c';
import DATE_GRADUATED from '@salesforce/schema/Education__c.DateGraduate__c';
import DEGREE_FIELD from '@salesforce/schema/Education__c.Degree__c';

import {refreshApex} from '@salesforce/apex';

//APEX CLASS
import RETURN_EDUCATION from '@salesforce/apex/GetEducationInformation.returnEducationList';

//import HATICON from '@salesforce/resourceUrl/hat';
//import EDITICON from '@salesforce/resourceUrl/editicon';
export default class Portfolioeducation extends LightningElement 
{
/*
    hatty = HATICON;
    editiconimplementation = EDITICON;
*/    
    @api recordId;
    @api objectApiName;
    @track modalChecker = false;
    educationObject = EDUCATION_OBJECT;
    userField = USER_FIELD;
    educationField = EDUCATION_FIELD;
    majorField = MAJOR_FIELD;
    degreeField = DEGREE_FIELD;
    gpaField = GPA_FIELD;
    dateGraduatedField = DATE_GRADUATED;

    @track education;
    @track wireValue;

    @wire(RETURN_EDUCATION)
    educationList(value) {
        const {error, data} = value;
        if(data) {this.education = data;}
        else if(error) {console.log(error);}
        console.log(this.education);
        this.wireValue = value;
    }
    
    
    modalOpener() 
    {
        this.modalChecker = true;
    }
    modalCloser() 
    {
        const closeenv = new ShowToastEvent({
            title: "Canceled",
            message: "You canceled inputting information.",
            variant: "error"
        });

        this.dispatchEvent(closeenv);
        this.modalChecker = false;
    }

    handleSuccess() 
    {
        const env = new ShowToastEvent({
            title: "Success",
            message: "Information Received.",
            variant: "success"
        });

        this.dispatchEvent(env);
        refreshApex(this.wireValue);
        this.modalChecker = false;
    }

}