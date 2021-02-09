;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\"http:\/\/video\.google\.com\/googleplayer\.swf\?docId=\d{19}\&hl=[a-z]{2}\")
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\"http://video.google.com/googleplayer.swf?docId=9839818819090583884&hl=ko\""
(define-fun Witness1 () String (seq.++ "\x22" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "." (seq.++ "g" (seq.++ "o" (seq.++ "o" (seq.++ "g" (seq.++ "l" (seq.++ "e" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "g" (seq.++ "o" (seq.++ "o" (seq.++ "g" (seq.++ "l" (seq.++ "e" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "y" (seq.++ "e" (seq.++ "r" (seq.++ "." (seq.++ "s" (seq.++ "w" (seq.++ "f" (seq.++ "?" (seq.++ "d" (seq.++ "o" (seq.++ "c" (seq.++ "I" (seq.++ "d" (seq.++ "=" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "9" (seq.++ "8" (seq.++ "1" (seq.++ "8" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "0" (seq.++ "9" (seq.++ "0" (seq.++ "5" (seq.++ "8" (seq.++ "3" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "&" (seq.++ "h" (seq.++ "l" (seq.++ "=" (seq.++ "k" (seq.++ "o" (seq.++ "\x22" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "\u00AD\x1\"http://video.google.com/googleplayer.swf?docId=8989585561448141248&hl=da\""
(define-fun Witness2 () String (seq.++ "\xad" (seq.++ "\x01" (seq.++ "\x22" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "." (seq.++ "g" (seq.++ "o" (seq.++ "o" (seq.++ "g" (seq.++ "l" (seq.++ "e" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "g" (seq.++ "o" (seq.++ "o" (seq.++ "g" (seq.++ "l" (seq.++ "e" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "y" (seq.++ "e" (seq.++ "r" (seq.++ "." (seq.++ "s" (seq.++ "w" (seq.++ "f" (seq.++ "?" (seq.++ "d" (seq.++ "o" (seq.++ "c" (seq.++ "I" (seq.++ "d" (seq.++ "=" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "5" (seq.++ "8" (seq.++ "5" (seq.++ "5" (seq.++ "6" (seq.++ "1" (seq.++ "4" (seq.++ "4" (seq.++ "8" (seq.++ "1" (seq.++ "4" (seq.++ "1" (seq.++ "2" (seq.++ "4" (seq.++ "8" (seq.++ "&" (seq.++ "h" (seq.++ "l" (seq.++ "=" (seq.++ "d" (seq.++ "a" (seq.++ "\x22" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "\x22" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "." (seq.++ "g" (seq.++ "o" (seq.++ "o" (seq.++ "g" (seq.++ "l" (seq.++ "e" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "g" (seq.++ "o" (seq.++ "o" (seq.++ "g" (seq.++ "l" (seq.++ "e" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "y" (seq.++ "e" (seq.++ "r" (seq.++ "." (seq.++ "s" (seq.++ "w" (seq.++ "f" (seq.++ "?" (seq.++ "d" (seq.++ "o" (seq.++ "c" (seq.++ "I" (seq.++ "d" (seq.++ "=" "")))))))))))))))))))))))))))))))))))))))))))))))))(re.++ ((_ re.loop 19 19) (re.range "0" "9"))(re.++ (str.to_re (seq.++ "&" (seq.++ "h" (seq.++ "l" (seq.++ "=" "")))))(re.++ ((_ re.loop 2 2) (re.range "a" "z")) (re.range "\x22" "\x22")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
