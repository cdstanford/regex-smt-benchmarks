;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = /\*[^\/]+/
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "/*\u00F2\u00D0/"
(define-fun Witness1 () String (str.++ "/" (str.++ "*" (str.++ "\u{f2}" (str.++ "\u{d0}" (str.++ "/" ""))))))
;witness2: "\u008A/*\u007F\u00B7\u00E3\u00D8\u00CB\u009C/\u00DC\u00E1\u00C2\u00C7\u00E0nK\u007F\x14"
(define-fun Witness2 () String (str.++ "\u{8a}" (str.++ "/" (str.++ "*" (str.++ "\u{7f}" (str.++ "\u{b7}" (str.++ "\u{e3}" (str.++ "\u{d8}" (str.++ "\u{cb}" (str.++ "\u{9c}" (str.++ "/" (str.++ "\u{dc}" (str.++ "\u{e1}" (str.++ "\u{c2}" (str.++ "\u{c7}" (str.++ "\u{e0}" (str.++ "n" (str.++ "K" (str.++ "\u{7f}" (str.++ "\u{14}" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "/" (str.++ "*" "")))(re.++ (re.+ (re.union (re.range "\u{00}" ".") (re.range "0" "\u{ff}"))) (re.range "/" "/")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
