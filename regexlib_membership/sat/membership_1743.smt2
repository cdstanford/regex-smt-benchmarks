;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^0[1-6]{1}(([0-9]{2}){4})|((\s[0-9]{2}){4})|((-[0-9]{2}){4})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-99-89-97-88"
(define-fun Witness1 () String (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "8" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "7" (str.++ "-" (str.++ "8" (str.++ "8" "")))))))))))))
;witness2: "\x11\u009A\u00B4-49-58-63-98"
(define-fun Witness2 () String (str.++ "\u{11}" (str.++ "\u{9a}" (str.++ "\u{b4}" (str.++ "-" (str.++ "4" (str.++ "9" (str.++ "-" (str.++ "5" (str.++ "8" (str.++ "-" (str.++ "6" (str.++ "3" (str.++ "-" (str.++ "9" (str.++ "8" ""))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "0" "0")(re.++ (re.range "1" "6") ((_ re.loop 4 4) ((_ re.loop 2 2) (re.range "0" "9"))))))(re.union ((_ re.loop 4 4) (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ ((_ re.loop 4 4) (re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
