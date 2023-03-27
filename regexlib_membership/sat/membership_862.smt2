;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([^,\n]+),([^,\n]+),([^@]+)@([^\.]+)\.([^,\n]+)\n)+([^,\n]+),([^,\n]+),([^@]+)@([^\.]+)\.([^,\n]+)\n?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00AC,\u00BD,xF@;!.\x2\xA\u008E,\x1D,?\x0\u00D0@T.^\xAF,\x17,(\x1CR\u00D7@\x3\u009D.8"
(define-fun Witness1 () String (str.++ "\u{ac}" (str.++ "," (str.++ "\u{bd}" (str.++ "," (str.++ "x" (str.++ "F" (str.++ "@" (str.++ ";" (str.++ "!" (str.++ "." (str.++ "\u{02}" (str.++ "\u{0a}" (str.++ "\u{8e}" (str.++ "," (str.++ "\u{1d}" (str.++ "," (str.++ "?" (str.++ "\u{00}" (str.++ "\u{d0}" (str.++ "@" (str.++ "T" (str.++ "." (str.++ "^" (str.++ "\u{0a}" (str.++ "F" (str.++ "," (str.++ "\u{17}" (str.++ "," (str.++ "(" (str.++ "\u{1c}" (str.++ "R" (str.++ "\u{d7}" (str.++ "@" (str.++ "\u{03}" (str.++ "\u{9d}" (str.++ "." (str.++ "8" ""))))))))))))))))))))))))))))))))))))))
;witness2: "\u00CET,\u00E9\u00C0\u00AA(\u00C2\u00D3\u00BC,w@e.\u00E6\u00EC\xAN\u00E5,\u00CA,\x12@\u00F7.\u008A\u00B3\xA=,U,\u00F9@q.\x12\u0082O\xA"
(define-fun Witness2 () String (str.++ "\u{ce}" (str.++ "T" (str.++ "," (str.++ "\u{e9}" (str.++ "\u{c0}" (str.++ "\u{aa}" (str.++ "(" (str.++ "\u{c2}" (str.++ "\u{d3}" (str.++ "\u{bc}" (str.++ "," (str.++ "w" (str.++ "@" (str.++ "e" (str.++ "." (str.++ "\u{e6}" (str.++ "\u{ec}" (str.++ "\u{0a}" (str.++ "N" (str.++ "\u{e5}" (str.++ "," (str.++ "\u{ca}" (str.++ "," (str.++ "\u{12}" (str.++ "@" (str.++ "\u{f7}" (str.++ "." (str.++ "\u{8a}" (str.++ "\u{b3}" (str.++ "\u{0a}" (str.++ "=" (str.++ "," (str.++ "U" (str.++ "," (str.++ "\u{f9}" (str.++ "@" (str.++ "q" (str.++ "." (str.++ "\u{12}" (str.++ "\u{82}" (str.++ "O" (str.++ "\u{0a}" "")))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "+") (re.range "-" "\u{ff}"))))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "+") (re.range "-" "\u{ff}"))))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\u{00}" "?") (re.range "A" "\u{ff}")))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "\u{00}" "-") (re.range "/" "\u{ff}")))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "+") (re.range "-" "\u{ff}")))) (re.range "\u{0a}" "\u{0a}")))))))))))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "+") (re.range "-" "\u{ff}"))))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "+") (re.range "-" "\u{ff}"))))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\u{00}" "?") (re.range "A" "\u{ff}")))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "\u{00}" "-") (re.range "/" "\u{ff}")))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "+") (re.range "-" "\u{ff}"))))(re.++ (re.opt (re.range "\u{0a}" "\u{0a}")) (str.to_re "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
