;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([A-Za-z]{0,}[\.\,\s]{0,}[A-Za-z]{1,}[\.\s]{1,}[0-9]{1,2}[\,\s]{0,}[0-9]{4})| ([0-9]{0,4}[-,\s]{0,}[A-Za-z]{3,9}[-,\s]{0,}[0-9]{1,2}[-,\s]{0,}[A-Za-z]{0,8})| ([0-9]{1,4}[\/\.\-][0-9]{1,4}[\/\.\-][0-9]{1,4})
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Lgt\u00A4Jd\u0085\u0085 B\xD\x9\u00A0934019"
(define-fun Witness1 () String (str.++ "L" (str.++ "g" (str.++ "t" (str.++ "\u{a4}" (str.++ "J" (str.++ "d" (str.++ "\u{85}" (str.++ "\u{85}" (str.++ " " (str.++ "B" (str.++ "\u{0d}" (str.++ "\u{09}" (str.++ "\u{a0}" (str.++ "9" (str.++ "3" (str.++ "4" (str.++ "0" (str.++ "1" (str.++ "9" ""))))))))))))))))))))
;witness2: "\u00C7\u00C2\x4\x7qwqZ.938989\u0098"
(define-fun Witness2 () String (str.++ "\u{c7}" (str.++ "\u{c2}" (str.++ "\u{04}" (str.++ "\u{07}" (str.++ "q" (str.++ "w" (str.++ "q" (str.++ "Z" (str.++ "." (str.++ "9" (str.++ "3" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "\u{98}" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (re.* (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "," ",")(re.union (re.range "." ".")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "." ".")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "," ",")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) ((_ re.loop 4 4) (re.range "0" "9"))))))))(re.union (re.++ (re.range " " " ") (re.++ ((_ re.loop 0 4) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "," "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 3 9) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "," "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "," "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) ((_ re.loop 0 8) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))) (re.++ (re.range " " " ") (re.++ ((_ re.loop 1 4) (re.range "0" "9"))(re.++ (re.range "-" "/")(re.++ ((_ re.loop 1 4) (re.range "0" "9"))(re.++ (re.range "-" "/") ((_ re.loop 1 4) (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
