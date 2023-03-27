;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(Sun|Mon|(T(ues|hurs))|Fri)(day|\.)?$|Wed(\.|nesday)?$|Sat(\.|urday)?$|T((ue?)|(hu?r?))\.?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Thu"
(define-fun Witness1 () String (str.++ "T" (str.++ "h" (str.++ "u" ""))))
;witness2: "Tue"
(define-fun Witness2 () String (str.++ "T" (str.++ "u" (str.++ "e" ""))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "S" (str.++ "u" (str.++ "n" ""))))(re.union (str.to_re (str.++ "M" (str.++ "o" (str.++ "n" ""))))(re.union (re.++ (re.range "T" "T") (re.union (str.to_re (str.++ "u" (str.++ "e" (str.++ "s" "")))) (str.to_re (str.++ "h" (str.++ "u" (str.++ "r" (str.++ "s" ""))))))) (str.to_re (str.++ "F" (str.++ "r" (str.++ "i" "")))))))(re.++ (re.opt (re.union (str.to_re (str.++ "d" (str.++ "a" (str.++ "y" "")))) (re.range "." "."))) (str.to_re ""))))(re.union (re.++ (str.to_re (str.++ "W" (str.++ "e" (str.++ "d" ""))))(re.++ (re.opt (re.union (re.range "." ".") (str.to_re (str.++ "n" (str.++ "e" (str.++ "s" (str.++ "d" (str.++ "a" (str.++ "y" ""))))))))) (str.to_re "")))(re.union (re.++ (str.to_re (str.++ "S" (str.++ "a" (str.++ "t" ""))))(re.++ (re.opt (re.union (re.range "." ".") (str.to_re (str.++ "u" (str.++ "r" (str.++ "d" (str.++ "a" (str.++ "y" "")))))))) (str.to_re ""))) (re.++ (re.range "T" "T")(re.++ (re.union (re.++ (re.range "u" "u") (re.opt (re.range "e" "e"))) (re.++ (re.range "h" "h")(re.++ (re.opt (re.range "u" "u")) (re.opt (re.range "r" "r")))))(re.++ (re.opt (re.range "." ".")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
