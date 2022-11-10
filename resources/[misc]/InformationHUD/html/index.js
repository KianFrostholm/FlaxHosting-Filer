
$(document).ready(function() {

    display = (bool) => {
        if (bool) {
            $('.bars-container').show()
        } else {
            $('.bars-container').hide()
        }
    }
    display(true)

    numberTranslate = (x) => {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    }

    $(function () {
        window.addEventListener('message', function (event) {
            var data = event.data

            if (data.type === 'update') {
                display(true)

                $('.bars-container > .wallet-bar > h3').text(`${numberTranslate(data.wallet)} DKK`);
                $('.bars-container > .reklame > h3').text(`${numberTranslate(data.bank)} DKK`);
                $('.bars-container > .bank-bar > h3').text(`${numberTranslate(data.bank)} DKK`);
                $('.bars-container > .dirtymoney-bar > h3').text(`${numberTranslate(data.dirty_money)} DKK`);

                if (data.job && data.job !== '') {
                    $('.bars-container > .identity-bar > h3').html(`<span style=' font-weight: bold; '>Job: </span>${data.job}<br><span style=' font-weight: bold; '>ID: </span>${data.id}`)
                    return
                }

                $('.bars-container > .identity-bar > h3').html(`<span style=' font-weight: bold; '>Job: </span>Intet<br><span style=' font-weight: bold; '>ID: </span>${data.id}`)
                return
            }

            if (data.type === 'close') {
                display(false)
                return
            }
        })
    })

})
