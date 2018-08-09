'use strict';

var snakeCase = require('lodash.snakecase');
var main = {
  up (str) {
    return str.toUpperCase()
  },
  low (str) {
    return str.toLowerCase()
  },
  snake (str) {
    return snakeCase(str)
  }
};

module.exports = main;
