;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(Sun|Mon|(T(ues|hurs))|Fri)(day|\.)?$|Wed(\.|nesday)?$|Sat(\.|urday)?$|T((ue?)|(hu?r?))\.?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Thu"
(define-fun Witness1 () String (seq.++ "T" (seq.++ "h" (seq.++ "u" ""))))
;witness2: "Tue"
(define-fun Witness2 () String (seq.++ "T" (seq.++ "u" (seq.++ "e" ""))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (str.to_re (seq.++ "S" (seq.++ "u" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "o" (seq.++ "n" ""))))(re.union (re.++ (re.range "T" "T") (re.union (str.to_re (seq.++ "u" (seq.++ "e" (seq.++ "s" "")))) (str.to_re (seq.++ "h" (seq.++ "u" (seq.++ "r" (seq.++ "s" ""))))))) (str.to_re (seq.++ "F" (seq.++ "r" (seq.++ "i" "")))))))(re.++ (re.opt (re.union (str.to_re (seq.++ "d" (seq.++ "a" (seq.++ "y" "")))) (re.range "." "."))) (str.to_re ""))))(re.union (re.++ (str.to_re (seq.++ "W" (seq.++ "e" (seq.++ "d" ""))))(re.++ (re.opt (re.union (re.range "." ".") (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "s" (seq.++ "d" (seq.++ "a" (seq.++ "y" ""))))))))) (str.to_re "")))(re.union (re.++ (str.to_re (seq.++ "S" (seq.++ "a" (seq.++ "t" ""))))(re.++ (re.opt (re.union (re.range "." ".") (str.to_re (seq.++ "u" (seq.++ "r" (seq.++ "d" (seq.++ "a" (seq.++ "y" "")))))))) (str.to_re ""))) (re.++ (re.range "T" "T")(re.++ (re.union (re.++ (re.range "u" "u") (re.opt (re.range "e" "e"))) (re.++ (re.range "h" "h")(re.++ (re.opt (re.range "u" "u")) (re.opt (re.range "r" "r")))))(re.++ (re.opt (re.range "." ".")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
