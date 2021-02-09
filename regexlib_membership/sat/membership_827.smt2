;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\*\.[a-zA-Z][a-zA-Z][a-zA-Z]$)|(^\*\.\*$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "*.Adz"
(define-fun Witness1 () String (seq.++ "*" (seq.++ "." (seq.++ "A" (seq.++ "d" (seq.++ "z" ""))))))
;witness2: "*.ZqY"
(define-fun Witness2 () String (seq.++ "*" (seq.++ "." (seq.++ "Z" (seq.++ "q" (seq.++ "Y" ""))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "*" (seq.++ "." "")))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "*" (seq.++ "." (seq.++ "*" "")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
