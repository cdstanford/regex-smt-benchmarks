;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <font[a-zA-Z0-9_\^\$\.\|\{\[\}\]\(\)\*\+\?\\~`!@#%&-=;:'",/\n\s]*>
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "<font>"
(define-fun Witness1 () String (str.++ "<" (str.++ "f" (str.++ "o" (str.++ "n" (str.++ "t" (str.++ ">" "")))))))
;witness2: "x\u00BD<font>"
(define-fun Witness2 () String (str.++ "x" (str.++ "\u{bd}" (str.++ "<" (str.++ "f" (str.++ "o" (str.++ "n" (str.++ "t" (str.++ ">" "")))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "<" (str.++ "f" (str.++ "o" (str.++ "n" (str.++ "t" ""))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " "=")(re.union (re.range "?" "~")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) (re.range ">" ">")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
