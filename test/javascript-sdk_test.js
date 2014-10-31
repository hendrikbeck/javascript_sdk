/*global describe,it*/
'use strict';
var assert = require('assert'),
  javascriptSdk = require('../lib/javascript-sdk2.js');

describe('javascript-sdk node module.', function() {
  it('must be awesome', function() {
    assert( javascriptSdk.awesome(), 'awesome');
  });
});
