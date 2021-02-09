;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([^\s]){5,12}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00AC\u00F4\u00E5!p"
(define-fun Witness1 () String (seq.++ "\xac" (seq.++ "\xf4" (seq.++ "\xe5" (seq.++ "!" (seq.++ "p" ""))))))
;witness2: "n\'\u008F^\x1B8\u00FD"
(define-fun Witness2 () String (seq.++ "n" (seq.++ "'" (seq.++ "\x8f" (seq.++ "^" (seq.++ "\x1b" (seq.++ "8" (seq.++ "\xfd" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 12) (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
