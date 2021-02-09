;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <body[\d\sa-z\W\S\s]*>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "v<body\u00C1>"
(define-fun Witness1 () String (seq.++ "v" (seq.++ "<" (seq.++ "b" (seq.++ "o" (seq.++ "d" (seq.++ "y" (seq.++ "\xc1" (seq.++ ">" "")))))))))
;witness2: "\x16\x7<body>\u00C2"
(define-fun Witness2 () String (seq.++ "\x16" (seq.++ "\x07" (seq.++ "<" (seq.++ "b" (seq.++ "o" (seq.++ "d" (seq.++ "y" (seq.++ ">" (seq.++ "\xc2" ""))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "<" (seq.++ "b" (seq.++ "o" (seq.++ "d" (seq.++ "y" ""))))))(re.++ (re.* (re.range "\x00" "\xff")) (re.range ">" ">")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
