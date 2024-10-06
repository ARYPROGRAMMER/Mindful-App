const fetchmoodData = require("../../application/usecases/getmoodData");
class UserController{
 
    static async usernames(req,res){
        try{
            const { username }= req.params;
            const moodData = new fetchmoodData();
            const moodata = await moodData.execute(username);
     
            return res.json(moodata);
       }
     
        catch(err){
            res.status(500).json({error: err.message});
        }
    }
}

module.exports = UserController;