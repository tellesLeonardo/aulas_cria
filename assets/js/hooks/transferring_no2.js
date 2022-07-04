const TransferringNo2 = {
    mounted() {
        this.el.addEventListener("input", over => {
            let cl2 =  this.el.getAttribute("data-cl2")
            let r22 = this.el.getAttribute("data-r22")
            let co2 = this.el.getAttribute("data-co2")
            let no2 = this.el.value

            console.log(this.el.value)

        });
        
    }
  }
  
  export default TransferringNo2