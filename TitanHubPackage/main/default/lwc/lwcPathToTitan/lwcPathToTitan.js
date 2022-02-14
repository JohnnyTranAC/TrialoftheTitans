import { LightningElement, api, wire } from 'lwc';

import getAccount from "@salesforce/apex/PathToTitanController.getAccount";
import getSquad from "@salesforce/apex/PathToTitanController.getSquad";
import getExamAndResultsList from "@salesforce/apex/PathToTitanController.getExamAndResultsList";
export default class LwcPathToTitan extends LightningElement {

    // Variables to Display Hero Details at Top of Component
    heroArete;
    heroTitle;
    heroName;
    squadName;


    // Lists to grab Exams & ExamResults related to Titan
    //examList = []; // ?? Wrapper Class to Hold Exam__c Object and Priority Tag / Unique Key for Iterator ??
    //examResultList = [];

    // Variables to receive from previous Component
    @api titanId = 'a0X8c00000Q3t7YEAR';
    @api accountId = '0018c000028TxZoAAK';

    @wire(getAccount) accInfo;
    @wire(getSquad) squadInfo;

    @wire(getExamAndResultsList, {titanId: '$titanId', accountId:'$accountId'}) 
    examAndResultsList;

   
    // Initialization Function to Populate Some Basic Information
    renderedCallback() {
        if (this.accInfo.data && this.squadInfo.data) {
            this.heroName = "Our Hero's Name: " + this.accInfo.data.Name;
            this.squadName = "Our Hero's Squad: " + this.squadInfo.data.Name;
            this.heroArete = "Our Hero's Arete: 19";
            this.heroTitle = "Our Hero's Title: Perseus";
        } 
    }
    // Navigation Function to pass titanId and accountId to lwcExamInterview
    handleExamClick(event) {
        //let exam_id = event.target.dataset.Exam__c;
    }

    get examTile.Status__c(){

    }

}