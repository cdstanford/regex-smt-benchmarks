;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^<>/?&{};#]+
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "yyV"
(define-fun Witness1 () String (str.++ "y" (str.++ "y" (str.++ "V" ""))))
;witness2: "\u008B\u00B4"
(define-fun Witness2 () String (str.++ "\u{8b}" (str.++ "\u{b4}" "")))

(assert (= regexA (re.+ (re.union (re.range "\u{00}" "\u{22}")(re.union (re.range "$" "%")(re.union (re.range "'" ".")(re.union (re.range "0" ":")(re.union (re.range "=" "=")(re.union (re.range "@" "z")(re.union (re.range "|" "|") (re.range "~" "\u{ff}")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
