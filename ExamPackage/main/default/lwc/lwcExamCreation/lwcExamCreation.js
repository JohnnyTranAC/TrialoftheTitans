import { LightningElement, api  } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { getRecord } from 'lightning/uiRecordApi';
import Exam_Object from '@salesforce/schema/Exam__c';


//Importing Fields
import NAME_FIELD from '@salesforce/schema/Exam__C.Name';
import NEXT_EXAM_FIELD from '@salesforce/schema/Exam__C.Next_Exam__c';
import TITAN_FIELD from '@salesforce/schema/Exam__C.Titan__c';
import DPG_FIELD from '@salesforce/schema/Exam__C.Default_Passing_Grade__c';
import DTL_FIELD from '@salesforce/schema/Exam__C.Default_Time_Limit__c';

export default class ExamCreation extends LightningElement {
    examObj = Exam_Object;
    examId;
    nameField = NAME_FIELD;
    nextExamField = NEXT_EXAM_FIELD;
    titanField = TITAN_FIELD;
    dPGField = DPG_FIELD;
    dTLField = DTL_FIELD;
    titan;
    exam;
    name = '';
    DPG = 0;
    DTL = 0;

    //Handler for the exam name for when Hero inputs data into input field
    handleExamName(event){
        this.examId = undefined;
        this.name = event.target.value;
    }

    //Handler for the Titan(a technology a hero (Account) would like to conquer) for when Hero inputs data into input field
    handleTitanInput(event){
        this.titan = event.target.value;
    }

    //Handler for the Nextexam name for when Hero inputs data into input field
    handleNextExamInput(event){
        this.exam = event.target.value;
    }

    //Handler for the Default Passing Grade for when Hero inputs data into input field
    handleDefaultPassingGradeInput(event){
        this.DPG = event.target.value;
    }

    //Handler for the Default Time Limit for when Hero inputs data into input field
    handleDefaultTimeLimitInput(event){
        this.DTL = event.target.value;
    }

    //Button submition that creates actual exam record.
    createExam(){
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.name;
        fields[NEXT_EXAM_FIELD.fieldApiName] = this.exam;
        fields[TITAN_FIELD.fieldApiName] = this.titan;
        fields[DPG_FIELD.fieldApiName] = this.DPG;
        fields[DTL_FIELD.fieldApiName] = this.DTL;

        const recordInput = {apiName: Exam_Object.objectApiName, fields};

        createRecord(record).then((account) => {this.examId = examId; this.dispatchEvent(new ShowToastEvent({title: "Success", message: "Account Created", variant: "success"})
        );
    })

    .catch((error) => {this.dispatchEvent(new ShowToastEvent({title: "Error in Creating Record", message: error.body.message, variant: "error"})
    );
});

    }

    
    

}