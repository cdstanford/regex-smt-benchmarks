;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <body[\d\sa-z\W\S\s]*>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "v<body\u00C1>"
(define-fun Witness1 () String (str.++ "v" (str.++ "<" (str.++ "b" (str.++ "o" (str.++ "d" (str.++ "y" (str.++ "\u{c1}" (str.++ ">" "")))))))))
;witness2: "\x16\x7<body>\u00C2"
(define-fun Witness2 () String (str.++ "\u{16}" (str.++ "\u{07}" (str.++ "<" (str.++ "b" (str.++ "o" (str.++ "d" (str.++ "y" (str.++ ">" (str.++ "\u{c2}" ""))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "<" (str.++ "b" (str.++ "o" (str.++ "d" (str.++ "y" ""))))))(re.++ (re.* (re.range "\u{00}" "\u{ff}")) (re.range ">" ">")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
