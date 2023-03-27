;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\*\.[a-zA-Z][a-zA-Z][a-zA-Z]$)|(^\*\.\*$)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "*.Adz"
(define-fun Witness1 () String (str.++ "*" (str.++ "." (str.++ "A" (str.++ "d" (str.++ "z" ""))))))
;witness2: "*.ZqY"
(define-fun Witness2 () String (str.++ "*" (str.++ "." (str.++ "Z" (str.++ "q" (str.++ "Y" ""))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "*" (str.++ "." "")))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "*" (str.++ "." (str.++ "*" "")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
