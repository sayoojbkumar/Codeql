
const { unflatten } = require('flat');

function unf(obj) {
    let object = unflatten(obj);
    console.log(obj)
}

unf(object)