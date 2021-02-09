;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\{\\f\d*)\\([^;]+;)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "{\f\\u008F;\u009A"
(define-fun Witness1 () String (seq.++ "{" (seq.++ "\x5c" (seq.++ "f" (seq.++ "\x5c" (seq.++ "\x8f" (seq.++ ";" (seq.++ "\x9a" ""))))))))
;witness2: "{\f1\\x1E;\u00B0\u00C6"
(define-fun Witness2 () String (seq.++ "{" (seq.++ "\x5c" (seq.++ "f" (seq.++ "1" (seq.++ "\x5c" (seq.++ "\x1e" (seq.++ ";" (seq.++ "\xb0" (seq.++ "\xc6" ""))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re (seq.++ "{" (seq.++ "\x5c" (seq.++ "f" "")))) (re.* (re.range "0" "9")))(re.++ (re.range "\x5c" "\x5c") (re.++ (re.+ (re.union (re.range "\x00" ":") (re.range "<" "\xff"))) (re.range ";" ";"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
