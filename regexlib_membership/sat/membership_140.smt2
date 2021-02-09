;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^A-Za-z0-9 ]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "hQ\u00AC"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "Q" (seq.++ "\xac" ""))))
;witness2: ")\u00EF\x1EK[\x13\u009B\u00CD"
(define-fun Witness2 () String (seq.++ ")" (seq.++ "\xef" (seq.++ "\x1e" (seq.++ "K" (seq.++ "[" (seq.++ "\x13" (seq.++ "\x9b" (seq.++ "\xcd" "")))))))))

(assert (= regexA (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "`") (re.range "{" "\xff")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
