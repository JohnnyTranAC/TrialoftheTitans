({
    doInit: function( component, event, helper ) {
        const getContextInfo = component.get( "c.getUserInfo" );
        getContextInfo.setCallback( this, function( response ) {
            console.log(response.getState());
            if( response.getState() === "SUCCESS" ){
                const contextinfo = response.getReturnValue();
                console.log( contextinfo );
                component.set( "v.contextInfo", response.getReturnValue );
            }
            else {
                //User isn't signed in return to login
            }
        });
        $A.enqueueAction( getContextInfo );
        
        const getTeamScores = component.get( "c.getTeamScores" );
        getTeamScores.setCallback( this, function( response ){
            console.log("TeamScores Response: " + response.getState());
            if( response.getState() === "SUCCESS"){
                let teamScores = response.getReturnValue();
                Object.keys(teamScores).forEach(category =>{
                    teamScores[category] = Object.entries(teamScores[category]).sort((a,b) => {
                    return a[1] < b[1]? 1 : -1;
                });
                });
                component.set('v.leadTeams', teamScores);
           }
        });

        $A.enqueueAction( getTeamScores );
    }
})