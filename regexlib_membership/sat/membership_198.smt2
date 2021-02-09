;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-zà-ïò-öù-ü]+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "ycz"
(define-fun Witness1 () String (seq.++ "y" (seq.++ "c" (seq.++ "z" ""))))
;witness2: "i\u00FC"
(define-fun Witness2 () String (seq.++ "i" (seq.++ "\xfc" "")))

(assert (= regexA (re.++ (re.+ (re.union (re.range "a" "z")(re.union (re.range "\xe0" "\xef")(re.union (re.range "\xf2" "\xf6") (re.range "\xf9" "\xfc"))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
