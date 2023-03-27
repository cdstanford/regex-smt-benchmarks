;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:[a-z]{3},\s+)?(\d{1,2})\s+([a-z]{3})\s+(\d{4})\s+([01][0-9]|2[0-3])\:([0-5][0-9])
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "bah,\u00A0 98\u00A0\u0085jze\u00A0\xC\x9 9065\u0085 \u00A023:59"
(define-fun Witness1 () String (str.++ "b" (str.++ "a" (str.++ "h" (str.++ "," (str.++ "\u{a0}" (str.++ " " (str.++ "9" (str.++ "8" (str.++ "\u{a0}" (str.++ "\u{85}" (str.++ "j" (str.++ "z" (str.++ "e" (str.++ "\u{a0}" (str.++ "\u{0c}" (str.++ "\u{09}" (str.++ " " (str.++ "9" (str.++ "0" (str.++ "6" (str.++ "5" (str.++ "\u{85}" (str.++ " " (str.++ "\u{a0}" (str.++ "2" (str.++ "3" (str.++ ":" (str.++ "5" (str.++ "9" ""))))))))))))))))))))))))))))))
;witness2: "vct, \xD 0 \u0085mlm\u00A09282  \u00A0\xD08:50"
(define-fun Witness2 () String (str.++ "v" (str.++ "c" (str.++ "t" (str.++ "," (str.++ " " (str.++ "\u{0d}" (str.++ " " (str.++ "0" (str.++ " " (str.++ "\u{85}" (str.++ "m" (str.++ "l" (str.++ "m" (str.++ "\u{a0}" (str.++ "9" (str.++ "2" (str.++ "8" (str.++ "2" (str.++ " " (str.++ " " (str.++ "\u{a0}" (str.++ "\u{0d}" (str.++ "0" (str.++ "8" (str.++ ":" (str.++ "5" (str.++ "0" ""))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ ((_ re.loop 3 3) (re.range "a" "z"))(re.++ (re.range "," ",") (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "a" "z"))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":") (re.++ (re.range "0" "5") (re.range "0" "9")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
