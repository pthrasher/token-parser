// This is the grammar that is used to generate the tokenParser.
// In order to use the parser, do the following:
//   import tokenParser from './path/to/hammer/tokenParser';
//   // Or if you're using this from outside of zeemee-messaging-client:
//   import { tokenParser } from 'zeemee-messaging-client';
//
// To use:
//   let myTokens = tokenParser.parse(myText);




// Test text:
//
//   This is a long message. ::tcu::.
//   Look at this cool photo! ::photoref1::
//
// Should produce this output:
//
//   [
//      {
//         "type": "text",
//         "value": "This is a long message. ",
//         "originalText": "This is a long message. "
//      },
//      {
//         "type": "token",
//         "value": "tcu",
//         "originalText": "::tcu::"
//      },
//      {
//         "type": "text",
//         "value": ".
//   Look at this cool photo! ",
//         "originalText": ".
//   Look at this cool photo! "
//      },
//      {
//         "type": "token",
//         "value": "photoref1",
//         "originalText": "::photoref1::"
//      }
//   ]


MessagePortions
  = MessagePortion +

MessagePortion
  = NonToken / Token

NonToken
  = letters:Letter+ {
    return {
      type: 'text',
      value: letters.join(''),
      originalText: letters.join(''),
    };
  }

Letter
  = ! Token letter:. { return letter }

Token
  = "::" tokenName:TokenName "::" {
    return {
      type: 'token',
      value: tokenName,
      originalText: "::" + tokenName + "::",
    };
  }

TokenName
  = name:[-_.+0-9a-zA-Z]+ { return name.join('') }
