;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = {.*}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E0\u0085{xi,\u00E3}\u00FF"
(define-fun Witness1 () String (seq.++ "\xe0" (seq.++ "\x85" (seq.++ "{" (seq.++ "x" (seq.++ "i" (seq.++ "," (seq.++ "\xe3" (seq.++ "}" (seq.++ "\xff" ""))))))))))
;witness2: "\u00A9\u0088(.{}d"
(define-fun Witness2 () String (seq.++ "\xa9" (seq.++ "\x88" (seq.++ "(" (seq.++ "." (seq.++ "{" (seq.++ "}" (seq.++ "d" ""))))))))

(assert (= regexA (re.++ (re.range "{" "{")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.range "}" "}")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
