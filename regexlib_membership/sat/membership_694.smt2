;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <!*[^<>]*>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0087\u00A3<!!>"
(define-fun Witness1 () String (seq.++ "\x87" (seq.++ "\xa3" (seq.++ "<" (seq.++ "!" (seq.++ "!" (seq.++ ">" "")))))))
;witness2: "\u00F0<>"
(define-fun Witness2 () String (seq.++ "\xf0" (seq.++ "<" (seq.++ ">" ""))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.* (re.range "!" "!"))(re.++ (re.* (re.union (re.range "\x00" ";")(re.union (re.range "=" "=") (re.range "?" "\xff")))) (re.range ">" ">"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
