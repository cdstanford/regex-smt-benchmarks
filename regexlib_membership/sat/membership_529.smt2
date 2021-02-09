;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = BV_SessionID=@@@@0106700396.1206001747@@@@&BV_EngineID=ccckadedjddehggcefecehidfhfdflg.0
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "BV_SessionID=@@@@0106700396\u00EC1206001747@@@@&BV_EngineID=ccckadedjddehggcefecehidfhfdflg\u00F20"
(define-fun Witness1 () String (seq.++ "B" (seq.++ "V" (seq.++ "_" (seq.++ "S" (seq.++ "e" (seq.++ "s" (seq.++ "s" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "I" (seq.++ "D" (seq.++ "=" (seq.++ "@" (seq.++ "@" (seq.++ "@" (seq.++ "@" (seq.++ "0" (seq.++ "1" (seq.++ "0" (seq.++ "6" (seq.++ "7" (seq.++ "0" (seq.++ "0" (seq.++ "3" (seq.++ "9" (seq.++ "6" (seq.++ "\xec" (seq.++ "1" (seq.++ "2" (seq.++ "0" (seq.++ "6" (seq.++ "0" (seq.++ "0" (seq.++ "1" (seq.++ "7" (seq.++ "4" (seq.++ "7" (seq.++ "@" (seq.++ "@" (seq.++ "@" (seq.++ "@" (seq.++ "&" (seq.++ "B" (seq.++ "V" (seq.++ "_" (seq.++ "E" (seq.++ "n" (seq.++ "g" (seq.++ "i" (seq.++ "n" (seq.++ "e" (seq.++ "I" (seq.++ "D" (seq.++ "=" (seq.++ "c" (seq.++ "c" (seq.++ "c" (seq.++ "k" (seq.++ "a" (seq.++ "d" (seq.++ "e" (seq.++ "d" (seq.++ "j" (seq.++ "d" (seq.++ "d" (seq.++ "e" (seq.++ "h" (seq.++ "g" (seq.++ "g" (seq.++ "c" (seq.++ "e" (seq.++ "f" (seq.++ "e" (seq.++ "c" (seq.++ "e" (seq.++ "h" (seq.++ "i" (seq.++ "d" (seq.++ "f" (seq.++ "h" (seq.++ "f" (seq.++ "d" (seq.++ "f" (seq.++ "l" (seq.++ "g" (seq.++ "\xf2" (seq.++ "0" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "BV_SessionID=@@@@0106700396]1206001747@@@@&BV_EngineID=ccckadedjddehggcefecehidfhfdflg\u00C00X\u009E#"
(define-fun Witness2 () String (seq.++ "B" (seq.++ "V" (seq.++ "_" (seq.++ "S" (seq.++ "e" (seq.++ "s" (seq.++ "s" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "I" (seq.++ "D" (seq.++ "=" (seq.++ "@" (seq.++ "@" (seq.++ "@" (seq.++ "@" (seq.++ "0" (seq.++ "1" (seq.++ "0" (seq.++ "6" (seq.++ "7" (seq.++ "0" (seq.++ "0" (seq.++ "3" (seq.++ "9" (seq.++ "6" (seq.++ "]" (seq.++ "1" (seq.++ "2" (seq.++ "0" (seq.++ "6" (seq.++ "0" (seq.++ "0" (seq.++ "1" (seq.++ "7" (seq.++ "4" (seq.++ "7" (seq.++ "@" (seq.++ "@" (seq.++ "@" (seq.++ "@" (seq.++ "&" (seq.++ "B" (seq.++ "V" (seq.++ "_" (seq.++ "E" (seq.++ "n" (seq.++ "g" (seq.++ "i" (seq.++ "n" (seq.++ "e" (seq.++ "I" (seq.++ "D" (seq.++ "=" (seq.++ "c" (seq.++ "c" (seq.++ "c" (seq.++ "k" (seq.++ "a" (seq.++ "d" (seq.++ "e" (seq.++ "d" (seq.++ "j" (seq.++ "d" (seq.++ "d" (seq.++ "e" (seq.++ "h" (seq.++ "g" (seq.++ "g" (seq.++ "c" (seq.++ "e" (seq.++ "f" (seq.++ "e" (seq.++ "c" (seq.++ "e" (seq.++ "h" (seq.++ "i" (seq.++ "d" (seq.++ "f" (seq.++ "h" (seq.++ "f" (seq.++ "d" (seq.++ "f" (seq.++ "l" (seq.++ "g" (seq.++ "\xc0" (seq.++ "0" (seq.++ "X" (seq.++ "\x9e" (seq.++ "#" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "B" (seq.++ "V" (seq.++ "_" (seq.++ "S" (seq.++ "e" (seq.++ "s" (seq.++ "s" (seq.++ "i" (seq.++ "o" (seq.++ "n" (seq.++ "I" (seq.++ "D" (seq.++ "=" (seq.++ "@" (seq.++ "@" (seq.++ "@" (seq.++ "@" (seq.++ "0" (seq.++ "1" (seq.++ "0" (seq.++ "6" (seq.++ "7" (seq.++ "0" (seq.++ "0" (seq.++ "3" (seq.++ "9" (seq.++ "6" ""))))))))))))))))))))))))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (str.to_re (seq.++ "1" (seq.++ "2" (seq.++ "0" (seq.++ "6" (seq.++ "0" (seq.++ "0" (seq.++ "1" (seq.++ "7" (seq.++ "4" (seq.++ "7" (seq.++ "@" (seq.++ "@" (seq.++ "@" (seq.++ "@" (seq.++ "&" (seq.++ "B" (seq.++ "V" (seq.++ "_" (seq.++ "E" (seq.++ "n" (seq.++ "g" (seq.++ "i" (seq.++ "n" (seq.++ "e" (seq.++ "I" (seq.++ "D" (seq.++ "=" (seq.++ "c" (seq.++ "c" (seq.++ "c" (seq.++ "k" (seq.++ "a" (seq.++ "d" (seq.++ "e" (seq.++ "d" (seq.++ "j" (seq.++ "d" (seq.++ "d" (seq.++ "e" (seq.++ "h" (seq.++ "g" (seq.++ "g" (seq.++ "c" (seq.++ "e" (seq.++ "f" (seq.++ "e" (seq.++ "c" (seq.++ "e" (seq.++ "h" (seq.++ "i" (seq.++ "d" (seq.++ "f" (seq.++ "h" (seq.++ "f" (seq.++ "d" (seq.++ "f" (seq.++ "l" (seq.++ "g" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.range "0" "0")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
