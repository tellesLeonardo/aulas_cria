const TransferringR22 = {
    mounted() {
        this.el.addEventListener("input", over => {
            let cl2 =  this.el.getAttribute("data-cl2")
            let no2 =  this.el.getAttribute("data-no2")
            let co2 = this.el.getAttribute("data-co2")
            let r22 = this.el.value 
            
            console.log(this.el.value)

        });
        
    }
  }
  
  export default TransferringR22