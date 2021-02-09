;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = /\*[^\/]+/
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "/*\u00F2\u00D0/"
(define-fun Witness1 () String (seq.++ "/" (seq.++ "*" (seq.++ "\xf2" (seq.++ "\xd0" (seq.++ "/" ""))))))
;witness2: "\u008A/*\u007F\u00B7\u00E3\u00D8\u00CB\u009C/\u00DC\u00E1\u00C2\u00C7\u00E0nK\u007F\x14"
(define-fun Witness2 () String (seq.++ "\x8a" (seq.++ "/" (seq.++ "*" (seq.++ "\x7f" (seq.++ "\xb7" (seq.++ "\xe3" (seq.++ "\xd8" (seq.++ "\xcb" (seq.++ "\x9c" (seq.++ "/" (seq.++ "\xdc" (seq.++ "\xe1" (seq.++ "\xc2" (seq.++ "\xc7" (seq.++ "\xe0" (seq.++ "n" (seq.++ "K" (seq.++ "\x7f" (seq.++ "\x14" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "/" (seq.++ "*" "")))(re.++ (re.+ (re.union (re.range "\x00" ".") (re.range "0" "\xff"))) (re.range "/" "/")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
