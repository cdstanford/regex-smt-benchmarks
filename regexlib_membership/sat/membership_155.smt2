;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^a-zA-Z0-9]+
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "@"
(define-fun Witness1 () String (seq.++ "@" ""))
;witness2: "@\u00E5?"
(define-fun Witness2 () String (seq.++ "@" (seq.++ "\xe5" (seq.++ "?" ""))))

(assert (= regexA (re.+ (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "`") (re.range "{" "\xff")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
