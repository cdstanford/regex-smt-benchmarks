;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\n &lt;&quot;']*([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xAW@a9p"
(define-fun Witness1 () String (str.++ "\u{0a}" (str.++ "W" (str.++ "@" (str.++ "a" (str.++ "9" (str.++ "p" "")))))))
;witness2: "q6y0l-@.\x13"
(define-fun Witness2 () String (str.++ "q" (str.++ "6" (str.++ "y" (str.++ "0" (str.++ "l" (str.++ "-" (str.++ "@" (str.++ "." (str.++ "\u{13}" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{0a}" "\u{0a}")(re.union (re.range " " " ")(re.union (re.range "&" "'")(re.union (re.range ";" ";")(re.union (re.range "l" "l")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))))) (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "@" "@") (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
