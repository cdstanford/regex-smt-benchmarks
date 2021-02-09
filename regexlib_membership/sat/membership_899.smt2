;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\w*|\W*]*<[[\w*|\W*]*|/[\w*|\W*]]>[\w*|\W*]*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "/\u00D2]>"
(define-fun Witness1 () String (seq.++ "/" (seq.++ "\xd2" (seq.++ "]" (seq.++ ">" "")))))
;witness2: "<\u00D0"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "\xd0" "")))

(assert (= regexA (re.union (re.++ (re.* (re.range "\x00" "\xff"))(re.++ (re.range "<" "<") (re.* (re.range "\x00" "\xff")))) (re.++ (re.range "/" "/")(re.++ (re.range "\x00" "\xff")(re.++ (str.to_re (seq.++ "]" (seq.++ ">" ""))) (re.* (re.range "\x00" "\xff"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
