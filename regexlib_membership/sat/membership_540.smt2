;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^<>/?&{};#]+
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "yyV"
(define-fun Witness1 () String (seq.++ "y" (seq.++ "y" (seq.++ "V" ""))))
;witness2: "\u008B\u00B4"
(define-fun Witness2 () String (seq.++ "\x8b" (seq.++ "\xb4" "")))

(assert (= regexA (re.+ (re.union (re.range "\x00" "\x22")(re.union (re.range "$" "%")(re.union (re.range "'" ".")(re.union (re.range "0" ":")(re.union (re.range "=" "=")(re.union (re.range "@" "z")(re.union (re.range "|" "|") (re.range "~" "\xff")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
