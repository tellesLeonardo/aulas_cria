const Transferringcl2 = {
    mounted() {
        this.el.addEventListener("input", over => {
            let no2 =  this.el.getAttribute("data-no2")
            let r22 = this.el.getAttribute("data-r22")
            let co2 = this.el.getAttribute("data-co2")
            let cl2 = this.el.value
            
            console.log(this.el.value)

        });
        
    }
  }
  
  export default Transferringcl2