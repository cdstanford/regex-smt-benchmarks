;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]+(?:\.)?(?: [a-zA-Z]+(?:\.)?)*)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Mh E."
(define-fun Witness1 () String (seq.++ "M" (seq.++ "h" (seq.++ " " (seq.++ "E" (seq.++ "." ""))))))
;witness2: "v"
(define-fun Witness2 () String (seq.++ "v" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.range "." ".")) (re.* (re.++ (re.range " " " ")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.range "." "."))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
