import{address01,abi01} from "./abi.js";
$(async function() {
    const address = address01
    const abi = abi01
    var web3 = null
    var contract = null
    var account = null
    if (window.ethereum === undefined) {
    alert("请安装metamask")
} else {
    try {
        const accounts = await window.ethereum.request({method: 'eth_requestAccounts'})
        account = accounts[0]
    } catch (e) {
    }
    web3 = new Web3(window.ethereum)
    contract = new web3.eth.Contract(abi, address)
}


    const amount = await contract.methods.balanceOf(account,2).call()
    $(".amount").text(amount)

    const owner = await contract.methods.owner().call()

    const status1 = await contract.methods.balanceOf(owner,0).call()
    if(status1 < 1){
        $(".img-1ava").text("Unavaliable")
    }else{
        $(".img-1ava").text("Avaliable")
    }
    const status2 = await contract.methods.balanceOf(owner,1).call()
    if(status2 < 1){
        $(".img-2ava").text("Unavaliable")
    }else{
        $(".img-2ava").text("Avaliable")
    }
   


    $(".btn-return").on("click", async function () {
    try{
        await contract.methods.returnBike(0).send({
            from:account
        })
    }catch(e){
        console.log(e)
    }

})

    $(".btn-transfer").on("click",async function(){
        try{
            await contract.methods.transferBoth($(".address-in").val(),2,$(".bct-in").val(),1).send({
                from:account
            })
        }catch(e){
            console.log(e)
        }
    })

    $(".btn1-rent").on("click",async function(){
        try{
            await contract.methods.rentBike(account,0,6).send({
                from:account
            })
        }catch(e){
            console.log(e)
        }
    })
    $(".btn1-return").on("click",async function(){
        try{
            await contract.methods.returnBike(0).send({
                from:account
            })
        }catch(e){
            console.log(e)
        }
    })

    $(".btn2-rent").on("click",async function(){
        try{
            console.log(account)
            await contract.methods.rentBike(account,1,6).send({
                from:account
            })
        }catch(e){
            console.log(e)
        }
    })
    $(".btn2-return").on("click",async function(){
        try{
            await contract.methods.returnBike(1).send({
                from:account
            })
        }catch(e){
            console.log(e)
        }
    })







})
