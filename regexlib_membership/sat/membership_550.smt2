;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\"http:\/\/video\.google\.com\/googleplayer\.swf\?docId=\d{19}\&hl=[a-z]{2}\")
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\"http://video.google.com/googleplayer.swf?docId=9839818819090583884&hl=ko\""
(define-fun Witness1 () String (str.++ "\u{22}" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "." (str.++ "g" (str.++ "o" (str.++ "o" (str.++ "g" (str.++ "l" (str.++ "e" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "g" (str.++ "o" (str.++ "o" (str.++ "g" (str.++ "l" (str.++ "e" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "y" (str.++ "e" (str.++ "r" (str.++ "." (str.++ "s" (str.++ "w" (str.++ "f" (str.++ "?" (str.++ "d" (str.++ "o" (str.++ "c" (str.++ "I" (str.++ "d" (str.++ "=" (str.++ "9" (str.++ "8" (str.++ "3" (str.++ "9" (str.++ "8" (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "0" (str.++ "9" (str.++ "0" (str.++ "5" (str.++ "8" (str.++ "3" (str.++ "8" (str.++ "8" (str.++ "4" (str.++ "&" (str.++ "h" (str.++ "l" (str.++ "=" (str.++ "k" (str.++ "o" (str.++ "\u{22}" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\u00AD\x1\"http://video.google.com/googleplayer.swf?docId=8989585561448141248&hl=da\""
(define-fun Witness2 () String (str.++ "\u{ad}" (str.++ "\u{01}" (str.++ "\u{22}" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "." (str.++ "g" (str.++ "o" (str.++ "o" (str.++ "g" (str.++ "l" (str.++ "e" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "g" (str.++ "o" (str.++ "o" (str.++ "g" (str.++ "l" (str.++ "e" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "y" (str.++ "e" (str.++ "r" (str.++ "." (str.++ "s" (str.++ "w" (str.++ "f" (str.++ "?" (str.++ "d" (str.++ "o" (str.++ "c" (str.++ "I" (str.++ "d" (str.++ "=" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "5" (str.++ "8" (str.++ "5" (str.++ "5" (str.++ "6" (str.++ "1" (str.++ "4" (str.++ "4" (str.++ "8" (str.++ "1" (str.++ "4" (str.++ "1" (str.++ "2" (str.++ "4" (str.++ "8" (str.++ "&" (str.++ "h" (str.++ "l" (str.++ "=" (str.++ "d" (str.++ "a" (str.++ "\u{22}" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "\u{22}" (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "." (str.++ "g" (str.++ "o" (str.++ "o" (str.++ "g" (str.++ "l" (str.++ "e" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "g" (str.++ "o" (str.++ "o" (str.++ "g" (str.++ "l" (str.++ "e" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "y" (str.++ "e" (str.++ "r" (str.++ "." (str.++ "s" (str.++ "w" (str.++ "f" (str.++ "?" (str.++ "d" (str.++ "o" (str.++ "c" (str.++ "I" (str.++ "d" (str.++ "=" "")))))))))))))))))))))))))))))))))))))))))))))))))(re.++ ((_ re.loop 19 19) (re.range "0" "9"))(re.++ (str.to_re (str.++ "&" (str.++ "h" (str.++ "l" (str.++ "=" "")))))(re.++ ((_ re.loop 2 2) (re.range "a" "z")) (re.range "\u{22}" "\u{22}")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
