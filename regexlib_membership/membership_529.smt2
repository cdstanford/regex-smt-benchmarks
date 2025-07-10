;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = BV_SessionID=@@@@0106700396.1206001747@@@@&BV_EngineID=ccckadedjddehggcefecehidfhfdflg.0
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "BV_SessionID=@@@@0106700396\u00EC1206001747@@@@&BV_EngineID=ccckadedjddehggcefecehidfhfdflg\u00F20"
(define-fun Witness1 () String (str.++ "B" (str.++ "V" (str.++ "_" (str.++ "S" (str.++ "e" (str.++ "s" (str.++ "s" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "I" (str.++ "D" (str.++ "=" (str.++ "@" (str.++ "@" (str.++ "@" (str.++ "@" (str.++ "0" (str.++ "1" (str.++ "0" (str.++ "6" (str.++ "7" (str.++ "0" (str.++ "0" (str.++ "3" (str.++ "9" (str.++ "6" (str.++ "\u{ec}" (str.++ "1" (str.++ "2" (str.++ "0" (str.++ "6" (str.++ "0" (str.++ "0" (str.++ "1" (str.++ "7" (str.++ "4" (str.++ "7" (str.++ "@" (str.++ "@" (str.++ "@" (str.++ "@" (str.++ "&" (str.++ "B" (str.++ "V" (str.++ "_" (str.++ "E" (str.++ "n" (str.++ "g" (str.++ "i" (str.++ "n" (str.++ "e" (str.++ "I" (str.++ "D" (str.++ "=" (str.++ "c" (str.++ "c" (str.++ "c" (str.++ "k" (str.++ "a" (str.++ "d" (str.++ "e" (str.++ "d" (str.++ "j" (str.++ "d" (str.++ "d" (str.++ "e" (str.++ "h" (str.++ "g" (str.++ "g" (str.++ "c" (str.++ "e" (str.++ "f" (str.++ "e" (str.++ "c" (str.++ "e" (str.++ "h" (str.++ "i" (str.++ "d" (str.++ "f" (str.++ "h" (str.++ "f" (str.++ "d" (str.++ "f" (str.++ "l" (str.++ "g" (str.++ "\u{f2}" (str.++ "0" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "BV_SessionID=@@@@0106700396]1206001747@@@@&BV_EngineID=ccckadedjddehggcefecehidfhfdflg\u00C00X\u009E#"
(define-fun Witness2 () String (str.++ "B" (str.++ "V" (str.++ "_" (str.++ "S" (str.++ "e" (str.++ "s" (str.++ "s" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "I" (str.++ "D" (str.++ "=" (str.++ "@" (str.++ "@" (str.++ "@" (str.++ "@" (str.++ "0" (str.++ "1" (str.++ "0" (str.++ "6" (str.++ "7" (str.++ "0" (str.++ "0" (str.++ "3" (str.++ "9" (str.++ "6" (str.++ "]" (str.++ "1" (str.++ "2" (str.++ "0" (str.++ "6" (str.++ "0" (str.++ "0" (str.++ "1" (str.++ "7" (str.++ "4" (str.++ "7" (str.++ "@" (str.++ "@" (str.++ "@" (str.++ "@" (str.++ "&" (str.++ "B" (str.++ "V" (str.++ "_" (str.++ "E" (str.++ "n" (str.++ "g" (str.++ "i" (str.++ "n" (str.++ "e" (str.++ "I" (str.++ "D" (str.++ "=" (str.++ "c" (str.++ "c" (str.++ "c" (str.++ "k" (str.++ "a" (str.++ "d" (str.++ "e" (str.++ "d" (str.++ "j" (str.++ "d" (str.++ "d" (str.++ "e" (str.++ "h" (str.++ "g" (str.++ "g" (str.++ "c" (str.++ "e" (str.++ "f" (str.++ "e" (str.++ "c" (str.++ "e" (str.++ "h" (str.++ "i" (str.++ "d" (str.++ "f" (str.++ "h" (str.++ "f" (str.++ "d" (str.++ "f" (str.++ "l" (str.++ "g" (str.++ "\u{c0}" (str.++ "0" (str.++ "X" (str.++ "\u{9e}" (str.++ "#" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "B" (str.++ "V" (str.++ "_" (str.++ "S" (str.++ "e" (str.++ "s" (str.++ "s" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "I" (str.++ "D" (str.++ "=" (str.++ "@" (str.++ "@" (str.++ "@" (str.++ "@" (str.++ "0" (str.++ "1" (str.++ "0" (str.++ "6" (str.++ "7" (str.++ "0" (str.++ "0" (str.++ "3" (str.++ "9" (str.++ "6" ""))))))))))))))))))))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (str.to_re (str.++ "1" (str.++ "2" (str.++ "0" (str.++ "6" (str.++ "0" (str.++ "0" (str.++ "1" (str.++ "7" (str.++ "4" (str.++ "7" (str.++ "@" (str.++ "@" (str.++ "@" (str.++ "@" (str.++ "&" (str.++ "B" (str.++ "V" (str.++ "_" (str.++ "E" (str.++ "n" (str.++ "g" (str.++ "i" (str.++ "n" (str.++ "e" (str.++ "I" (str.++ "D" (str.++ "=" (str.++ "c" (str.++ "c" (str.++ "c" (str.++ "k" (str.++ "a" (str.++ "d" (str.++ "e" (str.++ "d" (str.++ "j" (str.++ "d" (str.++ "d" (str.++ "e" (str.++ "h" (str.++ "g" (str.++ "g" (str.++ "c" (str.++ "e" (str.++ "f" (str.++ "e" (str.++ "c" (str.++ "e" (str.++ "h" (str.++ "i" (str.++ "d" (str.++ "f" (str.++ "h" (str.++ "f" (str.++ "d" (str.++ "f" (str.++ "l" (str.++ "g" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (re.range "0" "0")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
