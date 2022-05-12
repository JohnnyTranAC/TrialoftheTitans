import hero from '@salesforce/resourceUrl/hero';
import { LightningElement, track , api} from 'lwc';

export default class HeroResultsComponent extends LightningElement {
    //This is being grabbed from employerPartnerExperience
    @api heroes;
    @track msg = 'newest';
    @track pages={};
    @track currentPage=1;
    @track currentHeroes;
    @track remote;
    @track relocate;
    
   /* async nextPage(event){

        if((this.currentPage+1)*9<this.heroes.length){
            this.currentPage= [];
            
            let start= 9*(this.currentPage-1);
            let end = (9*this.currentPage);
            for (let i = start; i < heroes.length && i< end; i++) {
                this.currentHeroes.push(this.heroes[i]); 
            }
        }
        this.currentPage=this.currentPage+1;
        }
*/


handleCustomEvent(evt){
    
    this.msg = evt.detail.query;
    this.remote = evt.detail.remote;
    this.relocate = evt.detail.relocate;
    
}
}