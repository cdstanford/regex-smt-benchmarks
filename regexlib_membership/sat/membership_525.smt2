;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<Protocol>\w+):\/\/(?<Domain>[\w@][\w.:\-@]+)\/(?<Container>[\w= ,@-]+)*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x10\x4,\u0080]9://2:/\x8\x8\x13\u00E5"
(define-fun Witness1 () String (str.++ "\u{10}" (str.++ "\u{04}" (str.++ "," (str.++ "\u{80}" (str.++ "]" (str.++ "9" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "2" (str.++ ":" (str.++ "/" (str.++ "\u{08}" (str.++ "\u{08}" (str.++ "\u{13}" (str.++ "\u{e5}" "")))))))))))))))))
;witness2: "i://H\u00AA/\u00AA"
(define-fun Witness2 () String (str.++ "i" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "H" (str.++ "\u{aa}" (str.++ "/" (str.++ "\u{aa}" "")))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))(re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.range "@" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))) (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" ":")(re.union (re.range "@" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))(re.++ (re.range "/" "/") (re.* (re.+ (re.union (re.range " " " ")(re.union (re.range "," "-")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "@" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
