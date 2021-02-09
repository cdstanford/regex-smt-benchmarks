;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\.)?([a-zA-Z0-9_-]?)(\.)?([a-zA-Z0-9_-]?)(\.)?)+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "n.8."
(define-fun Witness1 () String (seq.++ "n" (seq.++ "." (seq.++ "8" (seq.++ "." "")))))
;witness2: "..9"
(define-fun Witness2 () String (seq.++ "." (seq.++ "." (seq.++ "9" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.opt (re.range "." "."))(re.++ (re.opt (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.opt (re.range "." "."))(re.++ (re.opt (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))) (re.opt (re.range "." "."))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
