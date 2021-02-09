;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?s)/\*.*\*/
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ";\u00AA/**/"
(define-fun Witness1 () String (seq.++ ";" (seq.++ "\xaa" (seq.++ "/" (seq.++ "*" (seq.++ "*" (seq.++ "/" "")))))))
;witness2: "/**/"
(define-fun Witness2 () String (seq.++ "/" (seq.++ "*" (seq.++ "*" (seq.++ "/" "")))))

(assert (= regexA (re.++ (str.to_re (seq.++ "/" (seq.++ "*" "")))(re.++ (re.* (re.range "\x00" "\xff")) (str.to_re (seq.++ "*" (seq.++ "/" "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
