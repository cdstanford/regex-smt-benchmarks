;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*-?(\d*\.)?([0-2])?[0-9]:([0-5])?[0-9]:([0-5])?[0-9](\.[0-9]{1,7})?\s*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0085-30.22:0:26.9\u0085\u0085"
(define-fun Witness1 () String (str.++ "\u{85}" (str.++ "-" (str.++ "3" (str.++ "0" (str.++ "." (str.++ "2" (str.++ "2" (str.++ ":" (str.++ "0" (str.++ ":" (str.++ "2" (str.++ "6" (str.++ "." (str.++ "9" (str.++ "\u{85}" (str.++ "\u{85}" "")))))))))))))))))
;witness2: "4:5:40.8 "
(define-fun Witness2 () String (str.++ "4" (str.++ ":" (str.++ "5" (str.++ ":" (str.++ "4" (str.++ "0" (str.++ "." (str.++ "8" (str.++ " " ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.++ (re.* (re.range "0" "9")) (re.range "." ".")))(re.++ (re.opt (re.range "0" "2"))(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.opt (re.range "0" "5"))(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.opt (re.range "0" "5"))(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 7) (re.range "0" "9"))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
